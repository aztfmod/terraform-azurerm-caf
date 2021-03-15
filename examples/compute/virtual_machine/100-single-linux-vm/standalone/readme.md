You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/compute/virtual_machine/100-single-linux-vm/standalone

terraform init

terraform [plan | apply | destroy ] \
  -var-file ../configuration.tfvars


```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/examples/compute/virtual_machine/100-single-linux-vm/ \
  -level level1 \
  -a [plan | apply | destroy ] 

```