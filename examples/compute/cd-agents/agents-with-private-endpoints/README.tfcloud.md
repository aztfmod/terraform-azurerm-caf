# Azure devops and TF Cloud agents

This deployment create a secure bootstrap environment to leverage private-endpoints from day 1. It creates a vnet gateway with two virtual machines to host the self-hosted agents.

To connect securely to this environment you need to generate a certificate to authorise your client to connect with openssl vpn and access the private ip of the services.

Note: Only the tfcloud deployment has been tested from now. Additional testing to come with new releases

## Generate the certificates

```bash
if [ -d ~/.certs ]; then
  echo "Existing certificate found in ~/.certs"
  echo "No need to re-generate a new one. To generate a new one, delete the ~/.certs folder and re-run that script."
else
  echo "No existing certificate profiles for openvpn found in ~/.certs"

  echo "What is your name (unique per devops team - It will generate a certificate for this container and add it to the VPN gateway)?"
  read name

  # Install strongswam Open VPN client and tools
  if [[ "$(echo $(which ipsec))" == "ipsec not found" ]]; then
    sudo apt-get update
    sudo apt install -y strongswan strongswan-pki libstrongswan-extra-plugins libtss2-tcti-tabrmd0 net-tools iputils-ping traceroute openvpn  network-manager-openvpn
  fi

  # Generate the certificate CA
  mkdir ~/.certs

  ipsec pki --gen --outform pem > ~/.certs/caKey.pem
  ipsec pki --self --in ~/.certs/caKey.pem --dn "CN=VPN Rover AZTFMOD Secure Bootstrap CA" --ca --outform pem > ~/.certs/caCert.pem

  ipsec pki --gen --outform pem > ~/.certs/${name}-Key.pem
  ipsec pki --pub --in ~/.certs/${name}-Key.pem | ipsec pki --issue --cacert ~/.certs/caCert.pem --cakey ~/.certs/caKey.pem --dn "CN=${name}" --san "${name}" --flag clientAuth --outform pem > ~/.certs/${name}-Cert.pem

  echo $(openssl x509 -in ~/.certs/caCert.pem -outform der | base64 -w0 ; echo) > ~/.certs/caCert64.pem
  chmod 740 ~/.certs/*
fi
```

## Setup the TFC environment and trigger the plan and apply

```bash

# Create a Teams or personnal token (not an organization token as some feature are not supported with that token)
terraform login

export AZDO_TOKEN=xxxxxx

# Generate a Team token, not an organizational token
export TFCLOUD_TOKEN=xxxxxx

export ARM_SUBSCRIPTION_ID=
export ARM_CLIENT_ID=xxxxx
export ARM_TENANT_NAME=xxxx.onmicrosoft.com
export ARM_TENANT_ID=xxxxx
export ARM_CLIENT_SECRET="xxxxxx"

az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET -t $ARM_TENANT_ID
az account set -s $ARM_SUBSCRIPTION_ID

export TF_CLOUD_ORGANIZATION=xxxx
export TF_CLOUD_HOSTNAME=app.terraform.io
export TF_CLOUD_PROJECT_ID=xxxxx   # TF Cloud project (must be created before)
export REMOTE_credential_path_json="$(echo ~)/.terraform.d/credentials.tfrc.json"  # Make sure you have executed terraform login first
export BACKEND_type_hybrid=false
export GITOPS_AGENT_POOL_EXECUTION_MODE=remote    # This deployment is using hosted TFC agents to bootstrap the environment
export TF_VAR_backend_type=remote

export TF_CLOUD_WORKSPACE_TF_ENV_bootstrap_root_ca_public_pem=$(cat ~/.certs/caCert64.pem)
export TF_CLOUD_WORKSPACE_TF_SEC_ENV_AZDO_TOKEN="$AZDO_TOKEN"
export TF_CLOUD_WORKSPACE_TF_SEC_ENV_TFCLOUD_TOKEN="$TFCLOUD_TOKEN"

export TF_CLOUD_WORKSPACE_ATTRIBUTES_ASSESSMENTS_ENABLED=true

export ROVER_RUNNER=true

rover \
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder /tf/caf/configuration/level0/tfcloud/bootstrap-with-private-endpoints \
  -tfstate_subscription_id $ARM_SUBSCRIPTION_ID \
  -target_subscription $ARM_SUBSCRIPTION_ID \
  -tfstate bootstrap.tfstate \
  -env xxx \
  -p ${TF_DATA_DIR}/bootstrap.tfstate.tfplan \
  -tf_cloud_force_run \
  -a plan 

# once finished execute the apply

```

## connect the vpn client to the Azure bootstrap

To connect the bootstrap environment and access the self-hosted VM you need to connect the rover container with openssl vpn to the gateway.

```
# Generate the VPN client profile
curl -sL -o ~/.certs/vpnconfig.zip $(az network vnet-gateway vpn-client generate \
  --ids $(az resource list --resource-type Microsoft.Network/virtualNetworkGateways \
  --subscription $ARM_SUBSCRIPTION_ID --query '[0].id' -o tsv) -o tsv)

unzip -o -d ~/.certs ~/.certs/vpnconfig.zip

if [[ ! -d "/dev/net" ]]; then
  sudo mkdir /dev/net
  sudo mknod /dev/net/tun c 10 200
  sudo openvpn --mktun --dev tun0
fi

sudo touch openvpn.log && sudo chmod 644 openvpn.log
sudo openvpn --config ~/.certs/OpenVPN/vpnconfig.ovpn --cert $(ls  ~/.certs/*-Cert.pem) --key $(ls  ~/.certs/*-Key.pem) --auth-nocache --single-session --dev tun0 &

nameserver=$(az resource show --ids $(az resource list --resource-type Microsoft.Network/dnsResolvers/inboundEndpoints --subscription $ARM_SUBSCRIPTION_ID --query '[0].id' -o tsv) --query 'properties.ipConfigurations[0].privateIpAddress' -o tsv)

NS_EXISTS=$(cat /etc/resolv.conf | grep "nameserver ${nameserver}")

if [[ "${NS_EXISTS}" == "" ]]; then
  echo "nameserver $nameserver" | cat - /etc/resolv.conf | sudo tee /etc/resolv.conf
fi

route
```

You should see the following routes:

```bash
➜  caf git:(main) route                                                                                        
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         172.17.0.1      0.0.0.0         UG    0      0        0 eth0
10.101.0.0      192.168.124.1   255.255.0.0     UG    0      0        0 tun0
10.102.0.0      192.168.124.1   255.255.0.0     UG    0      0        0 tun0
172.17.0.0      0.0.0.0         255.255.0.0     U     0      0        0 eth0
192.168.123.0   192.168.124.1   255.255.255.0   UG    0      0        0 tun0
192.168.124.0   0.0.0.0         255.255.255.248 U     0      0        0 tun0
```

## Connect to the ADO VM

Retrieve the vm objects and login


```bash
vm_ado=$(az resource list --resource-type Microsoft.Compute/VirtualMachines --query "[?contains(name, 'azdo')].{name:name, rg:resourceGroup}[0]" -o json)
vm_tfcloud=$(az resource list --resource-type Microsoft.Compute/VirtualMachines --query "[?contains(name, 'tfcloud')].{name:name, rg:resourceGroup}[0]" -o json)

az ssh vm -n $(echo $vm_ado | jq -r .name) -g $(echo $vm_ado | jq -r .rg) --prefer-private-ip
```

Note you are running this deployment with a service principal so you will login that VM with that account:
```bash
OpenSSH_8.9p1 Ubuntu-3ubuntu0.1, OpenSSL 3.0.2 15 Mar 2022
Welcome to Ubuntu 22.04.2 LTS (GNU/Linux 5.15.0-1040-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Tue Jun 27 00:34:48 UTC 2023

  System load:  0.05615234375      Processes:                170
  Usage of /:   25.4% of 28.89GB   Users logged in:          0
  Memory usage: 16%                IPv4 address for docker0: 172.17.0.1
  Swap usage:   0%                 IPv4 address for eth0:    192.168.123.197

 * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
   just raised the bar for easy, resilient and secure K8s cluster deployment.

   https://ubuntu.com/engage/secure-kubernetes-at-the-edge

Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


Last login: Mon Jun 26 23:27:24 2023 from 192.168.124.2
xxxxx-257a-4ee4-8cca-730821ed797f@vm-azdo-oct:~$
```

Connect to the TFE Agents VM
```bash
az ssh vm -n $(echo $vm_tfcloud | jq -r .name) -g $(echo $vm_tfcloud | jq -r .rg) --prefer-private-ip
```

### Commands

List agents:
```bash
sudo docker ps
CONTAINER ID   IMAGE                                      COMMAND                  CREATED          STATUS          PORTS     NAMES
f3efd76ae682   aztfmod/rover-agent:1.4.6-2306.2308-azdo   "/bin/bash -c '/bin/…"   52 minutes ago   Up 38 minutes             agent-azdo-level0-10
51988dc02174   aztfmod/rover-agent:1.4.6-2306.2308-azdo   "/bin/bash -c '/bin/…"   52 minutes ago   Up 38 minutes             agent-azdo-level0-9
e54cb0bba5e7   aztfmod/rover-agent:1.4.6-2306.2308-azdo   "/bin/bash -c '/bin/…"   53 minutes ago   Up 38 minutes             agent-azdo-level0-8
b993bf972c53   aztfmod/rover-agent:1.4.6-2306.2308-azdo   "/bin/bash -c '/bin/…"   53 minutes ago   Up 38 minutes             agent-azdo-level0-7
acf8329d27af   aztfmod/rover-agent:1.4.6-2306.2308-azdo   "/bin/bash -c '/bin/…"   53 minutes ago   Up 38 minutes             agent-azdo-level0-6
ab9df0686d96   aztfmod/rover-agent:1.4.6-2306.2308-azdo   "/bin/bash -c '/bin/…"   53 minutes ago   Up 38 minutes             agent-azdo-level0-5
83a66f87527b   aztfmod/rover-agent:1.4.6-2306.2308-azdo   "/bin/bash -c '/bin/…"   53 minutes ago   Up 38 minutes             agent-azdo-level0-4
e03ffb15bffb   aztfmod/rover-agent:1.4.6-2306.2308-azdo   "/bin/bash -c '/bin/…"   53 minutes ago   Up 38 minutes             agent-azdo-level0-3
87b321e980bb   aztfmod/rover-agent:1.4.6-2306.2308-azdo   "/bin/bash -c '/bin/…"   53 minutes ago   Up 38 minutes             agent-azdo-level0-2
bdc820dbee5d   aztfmod/rover-agent:1.4.6-2306.2308-azdo   "/bin/bash -c '/bin/…"   53 minutes ago   Up 38 minutes             agent-azdo-level0-1
```

Read the logs
```bash
sudo docker logs agent-azdo-level0-5
Connect to Azure AD using PAT TOKEN from VSTS_AGENT_INPUT_TOKEN

  ___                      ______ _            _ _
 / _ \                     | ___ (_)          | (_)
/ /_\ \_____   _ _ __ ___  | |_/ /_ _ __   ___| |_ _ __   ___  ___
|  _  |_  / | | | '__/ _ \ |  __/| | '_ \ / _ \ | | '_ \ / _ \/ __|
| | | |/ /| |_| | | |  __/ | |   | | |_) |  __/ | | | | |  __/\__ \
\_| |_/___|\__,_|_|  \___| \_|   |_| .__/ \___|_|_|_| |_|\___||___/
                                   | |
        agent v3.220.5             |_|          (commit 5faff7c)


>> End User License Agreements:

Building sources from a TFVC repository requires accepting the Team Explorer Everywhere End User License Agreement. This step is not required for building sources from Git repositories.

A copy of the Team Explorer Everywhere license agreement can be found at:
  /home/vscode/agent/license.html


>> Connect:

Connecting to server ...

>> Register Agent:

Scanning for tool capabilities.
Connecting to the server.
Successfully added the agent
Testing agent connection.
2023-06-26 23:57:46Z: Settings Saved.
Scanning for tool capabilities.
Connecting to the server.
2023-06-26 23:57:51Z: Listening for Jobs
```

Each agent is hosted in a container and a linux service to restart automatically after VM reboots
```bash
sudo ls -l /etc/systemd/system/rover-*
-rw-r--r-- 1 root root 351 Jun 26 23:43 /etc/systemd/system/rover-agent-azdo-level0-10.service
-rw-r--r-- 1 root root 349 Jun 26 23:42 /etc/systemd/system/rover-agent-azdo-level0-1.service
-rw-r--r-- 1 root root 349 Jun 26 23:43 /etc/systemd/system/rover-agent-azdo-level0-2.service
-rw-r--r-- 1 root root 349 Jun 26 23:43 /etc/systemd/system/rover-agent-azdo-level0-3.service
-rw-r--r-- 1 root root 349 Jun 26 23:43 /etc/systemd/system/rover-agent-azdo-level0-4.service
-rw-r--r-- 1 root root 349 Jun 26 23:43 /etc/systemd/system/rover-agent-azdo-level0-5.service
-rw-r--r-- 1 root root 349 Jun 26 23:43 /etc/systemd/system/rover-agent-azdo-level0-6.service
-rw-r--r-- 1 root root 349 Jun 26 23:43 /etc/systemd/system/rover-agent-azdo-level0-7.service
-rw-r--r-- 1 root root 349 Jun 26 23:43 /etc/systemd/system/rover-agent-azdo-level0-8.service
-rw-r--r-- 1 root root 349 Jun 26 23:43 /etc/systemd/system/rover-agent-azdo-level0-9.service
```

Display the status of a service
```bash
sudo systemctl status rover-agent-azdo-level0-1.service
● rover-agent-azdo-level0-1.service - Rover agents
     Loaded: loaded (/etc/systemd/system/rover-agent-azdo-level0-1.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2023-06-26 23:57:31 UTC; 45min ago
   Main PID: 3275 (docker)
      Tasks: 9 (limit: 9516)
     Memory: 22.6M
        CPU: 178ms
     CGroup: /system.slice/rover-agent-azdo-level0-1.service
             └─3275 /usr/bin/docker start -a agent-azdo-level0-1

Jun 26 23:57:57 vm-azdo-oct docker[3275]: Connecting to server ...
Jun 26 23:58:00 vm-azdo-oct docker[3275]: >> Register Agent:
Jun 26 23:58:00 vm-azdo-oct docker[3275]: Scanning for tool capabilities.
Jun 26 23:58:00 vm-azdo-oct docker[3275]: Connecting to the server.
Jun 26 23:58:01 vm-azdo-oct docker[3275]: Successfully added the agent
Jun 26 23:58:01 vm-azdo-oct docker[3275]: Testing agent connection.
Jun 26 23:58:03 vm-azdo-oct docker[3275]: 2023-06-26 23:58:03Z: Settings Saved.
Jun 26 23:58:04 vm-azdo-oct docker[3275]: Scanning for tool capabilities.
Jun 26 23:58:04 vm-azdo-oct docker[3275]: Connecting to the server.
Jun 26 23:58:07 vm-azdo-oct docker[3275]: 2023-06-26 23:58:07Z: Listening for Jobs
```

Start the service
```bash
sudo systemctl start rover-agent-azdo-level0-1.service
```

Stop the service
```bash
sudo systemctl stop rover-agent-azdo-level0-1.service
```

How to check if a job is running a terraform job
```bash
# Job is running
sudo docker exec agent-tfe-4 ps | grep 'terraform'
     50 ?        00:00:07 terraform
    173 ?        00:00:00 terraform-provi
    181 ?        00:00:00 terraform-provi
    191 ?        00:00:00 terraform-provi
    201 ?        00:00:00 terraform-provi
    210 ?        00:00:00 terraform-provi
```

Supported scenarios:
- Increase and decrease the number of agents 
- If more agents are deployed that the max number of licensed agents, the additional agents are terminated in error state
- Change the rover image (will remove and redeploy the docker containers) to upgrade Terraform and the Agent version https://hub.docker.com/repository/docker/aztfmod/rover-agent/tags?page=1&ordering=last_updated
- Change the content of the script (will remove and redeploy the docker containers)
- Cleanup un-used images and containers

Important information
Agents in VM are not ephemeral. We are planning to bring that support through the AKS host.