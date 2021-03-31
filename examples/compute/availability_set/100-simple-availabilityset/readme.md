You can test this module outside of a landingzone using

```
configuration_folder=/tf/caf/examples/compute/availability_set/100-simple-availabilityset
parameter_files=$(find ${configuration_folder} | grep .tfvars | sed 's/.*/-var-file &/' | xargs)

cd /tf/caf/landingzones/caf_example

terraform init

eval terraform plan ${parameter_files} \
  -var var_folder_path="${configuration_folder}"

```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash
cd /tf/caf/examples/compute/availability_set/100-simple-availabilityset

current_folder=$(pwd)
parameter_files=$(find ${current_folder} | grep .tfvars | sed 's/.*/-var-file &/' | xargs)

rover \
  -lz /tf/caf/landingzones/caf_example \
  ${parameter_files} \
  -level level1 \
  -a plan

```