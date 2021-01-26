You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/networking/virtual_wan/102-vwan-multi-hubs-gw/standalone

terraform init

terraform plan \
  -var-file ../virtual_wan.tfvars


```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/examples/networking/virtual_wan/102-vwan-multi-hubs-gw/ \
  -level level1 \
  -a plan

```