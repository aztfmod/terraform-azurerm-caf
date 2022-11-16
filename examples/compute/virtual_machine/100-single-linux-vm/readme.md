You can test this module outside of a landingzone using

```bash
configuration_folder=/tf/caf/examples/compute/virtual_machine/100-single-linux-vm
parameter_files=$(find ${configuration_folder} | grep .tfvars | sed 's/.*/-var-file &/' | xargs)

cd /tf/caf/landingzones/caf_example
terraform init
terraform [plan | apply | destroy ] \
  -var-file ../configuration.tfvars


```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

configuration_folder=/tf/caf/examples/compute/virtual_machine/100-single-linux-vm

rover \
  -lz /tf/caf/landingzones/caf_example \
  -var-folder ${configuration_folder} \
  -level level1 \
  -a [plan | apply | destroy ]

```