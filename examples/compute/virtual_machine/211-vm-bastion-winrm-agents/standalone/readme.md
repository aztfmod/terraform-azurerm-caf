You can test this module outside of a landingzone using

```bash
configuration_folder=/tf/caf/examples/compute/virtual_machine/211-vm-bastion-winrm-agents
parameter_files=$(find ${configuration_folder} | grep .tfvars | sed 's/.*/-var-file &/' | xargs)

cd /tf/caf/landingzones/caf_example

terraform init

eval terraform plan ${parameter_files} \
  -var var_folder_path="${configuration_folder}"


```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/landingzones/caf_example \
  -var-folder /tf/caf/aztfmod/examples/compute/virtual_machine/211-vm-bastion-winrm-agents \
  -var var_folder_path="/tf/caf/aztfmod/examples/compute/virtual_machine/211-vm-bastion-winrm-agents" \
  -level level1 \
  -a plan

```