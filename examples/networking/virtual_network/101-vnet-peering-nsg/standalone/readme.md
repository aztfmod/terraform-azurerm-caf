You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/networking/virtual_network/101-vnet-peering-nsg/standalone

terraform init

terraform plan \
  -var-file ../configuration.tfvars \
  -var-file ../peering.tfvars \
  -var-file ../network_security_group_definition.tfvars \
  -var-file ../virtual_networks.tfvars

```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/examples/networking/virtual_network/101-vnet-peering-nsg/standalone/ \
  -level level1 \
  -a plan

```