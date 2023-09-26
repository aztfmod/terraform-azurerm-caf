#!/bin/bash

#
# Support UBUNTU and RHEL
# Azure devops and tfcloud agent
#
# to be used with virtual_machine_extensions.devops_selfhosted_agent and virtual_machine_extensions.tfcloud_selfhosted_agent
#

agent_type=${1}
url=${2}
token=${3}
agent_prefix=${4}
num_agent=${5}
admin_user=${6}
rover_version="${7}"
agent_pool=${8}

error() {
    local parent_lineno="$1"
    local message="$2"
    local code="${3:-1}"
    if [[ -n "$message" ]] ; then
        >&2 echo -e "\e[41mError on or near line ${parent_lineno}: ${message}; exiting with status ${code}\e[0m"
    else
        >&2 echo -e "\e[41mError on or near line ${parent_lineno}; exiting with status ${code}\e[0m"
    fi
    echo ""
    exit "${code}"
}

set -ETe
trap 'error ${LINENO}' ERR 1 2 3 6

get_os_edition() {
  if [ -f /etc/os-release ]; then
    source /etc/os-release
    if [[ $ID == "ubuntu" ]]; then
        echo "Ubuntu"
    elif [[ $ID == "rhel" || $ID == "rhel server" ]]; then
        echo "RHEL"
    else
        echo "Unknown"
    fi
  elif [ -f /etc/lsb-release ]; then
      echo "Ubuntu"
  elif [ -f /etc/redhat-release ]; then
      echo "RHEL"
  else
      echo "Unknown"
  fi
}

install_docker_rhel() {
  echo "Remove any containerd installation"
  sudo rm -rf /etc/containers/* /var/lib/containers/* /etc/docker /etc/subuid* /etc/subgid*
  sudo yum remove -y buildah skopeo podman containers-common atomic-registries docker
  sudo rm -rf /home/*/.local/share/containers/


  echo "install missing packages"

  sudo yum-config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
  #
  # Uncomment if you need to install a specific version
  #
  # sudo yum install -y python3-dnf-plugin-versionlock
  # sudo yum versionlock docker-ce-3:20.10.24*
  # sudo yum versionlock docker-ce-cli-1:20.10.24*
  # sudo yum versionlock containerd.io-1.6.20*
  sudo yum install -y docker-ce docker-ce-cli containerd.io
  # sudo systemctl disable firewalld
  sudo systemctl enable --now docker
  sleep 10
  sudo systemctl start docker.service
}

install_docker_ubuntu() {
  export DEBIAN_FRONTEND=noninteractive
  echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

  apt-get update
  apt-get install -y --no-install-recommends \
    ca-certificates \
    apt-transport-https \
    docker.io \
    sudo

  echo "Allowing agent to run docker"

  systemctl enable docker
  service docker start
}


echo "start"

os=$(get_os_edition)

case "$os" in
  Ubuntu)
    install_docker_ubuntu
    ;;
  RHEL)
    install_docker_rhel
    ;;
  *)
    error "This operating system is not yet supported: ($os)"
esac

docker --version
sudo systemctl status docker


# Pull rover base image
echo "Rover docker image ${rover_version}"
sudo docker pull "${rover_version}"

# Remove all previous containers and let systemctl restatring them
# Preview to be fortified
containers=$(sudo docker ps -a --format "{{.Names}}")
for container in $containers
do
  # Check if container is running
  running_status=$(sudo docker inspect --format "{{.State.Running}}" $container)
  if [[ "$running_status" == "true" ]]; then
    status="Running"

    output=$(sudo docker exec $container ps)
    if echo "$output" | grep -q -e "terraform"; then
      echo "String contains 'terraform'"
      echo "Waiting for process with 'terraform' in command to complete in container: $container"
      # TODO: to be executed in the container
      # while kill -0 $pid >/dev/null 2>&1; do
      #   sleep 1
      # done
      echo "Process completed. Killing container: $container"
    fi
    echo "Stopping agent: ${container}"
    sudo systemctl disable $container.service || true

    case "${agent_type}" in
      azdo)
        sudo docker exec -u vscode $container /bin/bash -c '/home/vscode/agent/config.sh remove --unattended && exit 250' || true
        ;;
      tfcloud)
        sudo docker stop --signal "SIGTERM" "$container"
        ;;
    esac

    sudo docker rm -f $container
  else
    status="Stopped"
    file="/etc/systemd/system/$container.service"
    sudo rm -rf $file || true
    sudo docker rm -f "$container" || true
  fi
done

files="/etc/systemd/system/*.service"
sudo rm -rf $files

echo "Install Azure Devops Agent ($os)"

for agent_num in $(seq 1 ${num_agent}); do
  AGENT_NAME="$agent_prefix-$agent_num"

  case "${agent_type}" in
    azdo)
      sudo docker create --name "$AGENT_NAME" -u "vscode" -e VSTS_AGENT_INPUT_TOKEN="$token" -e VSTS_AGENT_INPUT_AGENT="$AGENT_NAME" -e VSTS_AGENT_INPUT_URL="$url" -e VSTS_AGENT_INPUT_POOL=${agent_pool} ${rover_version}
      ;;
    tfcloud)
      sudo docker create --name "$AGENT_NAME" -u "vscode" -e TFC_AGENT_TOKEN="$token" -e TFC_AGENT_NAME="$AGENT_NAME" -e TFC_ADDRESS="$url" -e TFC_AGENT_LOG_LEVEL='info' --stop-signal 'SIGINT' --stop-timeout 15 ${rover_version}
      ;;
  esac

  # Create a service for each agent to restart them automatically on reboot
  file="/etc/systemd/system/$AGENT_NAME.service"
  sudo touch $file
  echo "[Unit]" | sudo tee $file > /dev/null
  echo "Description=Rover agents" | sudo tee -a $file > /dev/null
  echo "Requires=docker.service" | sudo tee -a $file > /dev/null
  echo "After=docker.service" | sudo tee -a $file > /dev/null
  echo "[Service]" | sudo tee -a $file > /dev/null
  # set to always to handle agent reconnection after a reboot of the underlying host vm.
  echo "Restart=always" | sudo tee -a $file > /dev/null

  start="/usr/bin/docker start -a $AGENT_NAME"
  echo "ExecStart=$start" | sudo tee -a $file > /dev/null

  case "${agent_type}" in
    azdo)
      stop="/usr/bin/docker exec -u vscode $AGENT_NAME /bin/bash -c '/home/vscode/agent/config.sh remove --unattended && exit 250'"
      ;;
    tfcloud)
      stop="/usr/bin/docker stop --signal "SIGTERM" $AGENT_NAME"
      ;;
  esac

  echo "ExecStop=$stop" | sudo tee -a $file > /dev/null
  echo "SuccessExitStatus=250" | sudo tee -a $file > /dev/null
  echo "[Install]" | sudo tee -a $file > /dev/null
  echo "WantedBy=default.target" | sudo tee -a $file > /dev/null


  sudo systemctl daemon-reload
  sudo systemctl enable $AGENT_NAME.service
  sudo systemctl start $AGENT_NAME.service
  sudo systemctl status $AGENT_NAME.service
done

sudo docker system prune -a -f
sudo docker ps