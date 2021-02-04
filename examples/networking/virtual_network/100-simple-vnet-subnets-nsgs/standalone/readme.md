You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/networking/virtual_network/100-simple-vnet-subnets-nsgs/standalone

terraform init

terraform plan \
  -var-file ../configuration.tfvars \
  -var-file ../nsg.tfvars \
  -var-file ../public-ip-addresses.tfvars \
  -var-file ../routes.tfvars

```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/examples/networking/virtual_network/100-simple-vnet-subnets-nsgs/ \
  -level level1 \
  -a plan

```