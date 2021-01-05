You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/networking/virtual_network_gateway_connections/100-expressroute-gateway-connection/standalone

terraform init

terraform plan \
  -var-file ../configuration.tfvars


```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/examples/networking/virtual_network_gateway_connections/100-expressroute-gateway-connection/ \
  -level level1 \
  -a plan

```