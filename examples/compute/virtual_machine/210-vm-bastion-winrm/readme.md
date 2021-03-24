You can test this module outside of a landingzone using

```bash
configuration_folder=/tf/caf/examples/compute/virtual_machine/210-vm-bastion-winrm
parameter_files=$(find ${configuration_folder} | grep .tfvars | sed 's/.*/-var-file &/' | xargs)

cd /tf/caf/landingzones/caf_example

terraform init

eval terraform plan ${parameter_files} \
  -state 210-vm-bastion-winrm.tfstate \
  -var var_folder_path="${configuration_folder}"


```

Rover deployment in landingzones

```
configuration_folder=/tf/caf/examples/compute/virtual_machine/210-vm-bastion-winrm
parameter_files=$(find ${configuration_folder} | grep .tfvars | sed 's/.*/-var-file &/' | xargs)

rover -lz /tf/caf/landingzones/caf_example \
  ${parameter_files} \
  -tfstate 210-vm-bastion-winrm.tfstate\
  -level level1 \
  -a plan
```