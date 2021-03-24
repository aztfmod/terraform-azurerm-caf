You can test this module outside of a landingzone using

```
cd /tf/caf/examples/compute/container_registry/100-simple-acr/standalone

terraform init

terraform [plan | apply | destroy] \
  -var-file ../configuration.tfvars

```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/landingzones/caf_example \
  -var-folder  /tf/caf/examples/compute/container_registry/100-simple-acr/ \
  -level level1 \
  -a [plan | apply | destroy]

```