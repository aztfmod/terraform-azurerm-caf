You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/machine_learning/101-aml-vnet/standalone

terraform init

terraform plan \
  -var-file ../configuration.tfvars \
  -var-file ../networking_spoke.tfvars

```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/examples/machine_learning/101-aml-vnet/\
  -level level1 \
  -a plan

```