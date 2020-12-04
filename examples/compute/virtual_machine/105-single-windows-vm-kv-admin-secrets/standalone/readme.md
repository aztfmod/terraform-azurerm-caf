You can test this module outside of a landingzone using

```bash
cd /tf/caf/aztfmod/examples/compute/virtual_machine/105-single-windows-vm-kv-admin-secrets/standalone

terraform init

terraform plan \
  -var-file ../configuration.tfvars \
  -var-file ../diagnostics.tfvars \
  -var-file ../keyvaults.tfvars \
  -var-file ../nsg_definitions.tfvars \
  -var-file ../virtual_networks.tfvars \
  -var-file ../public_ip_addresses.tfvars \
  -var-file ../virtual_machines.tfvars \
  -var var_folder_path="/tf/caf/aztfmod/examples/compute/virtual_machine/211-vm-bastion-winrm-agents"


```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder /tf/caf/aztfmod/examples/compute/virtual_machine/211-vm-bastion-winrm-agents \
  -var var_folder_path="/tf/caf/aztfmod/examples/compute/virtual_machine/211-vm-bastion-winrm-agents" \
  -a plan
  
```