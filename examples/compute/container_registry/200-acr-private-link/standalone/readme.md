You can test this module outside of a landingzone using

```
cd /tf/caf/examples/compute/container_registry/200-acr-private-link/standalone

terraform init

terraform plan \
  -var-file ../configuration.tfvars 


```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/examples/compute/container_registry/200-acr-private-link/ \
  -level level1 \
  -a plan

```