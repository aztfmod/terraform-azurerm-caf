You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/networking/private_dns/100-private-dns-vnet-links/standalone

terraform init

terraform plan \
  -var-file ../configuration.tfvars 

```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/examples/networking/private_dns/100-private-dns-vnet-links/ \
  -level level1 \
  -a plan

```