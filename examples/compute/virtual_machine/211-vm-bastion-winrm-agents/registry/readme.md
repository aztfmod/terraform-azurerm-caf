This example shows how to deploy a virtual machine from a standalone module using the public registry

You can test this module outside of a landingzone

Make sure you execute the following commands from a linux bash environment. The recommended approach is to use the rover as it is the environment used for the integration tests. Some modules are using local-exec and requires the rover to garantee a correct execution.

The username and password of the wm are set into the keyvaults.tfvars

```bash
# adjuts the base path of the example folder if needed
base_module_path="/tf/caf/examples/compute/virtual_machine/211-vm-bastion-winrm-agents"
cd ${base_module_path}/registry

terraform init

terraform plan \
  -var-file ../configuration.tfvars \
  -var-file ../diagnostics.tfvars \
  -var-file ../keyvaults.tfvars \
  -var-file ../nsg_definitions.tfvars \
  -var-file ../virtual_networks.tfvars \
  -var-file ../public_ip_addresses.tfvars \
  -var-file ../virtual_machines.tfvars \
  -var var_folder_path=${base_module_path}


```
