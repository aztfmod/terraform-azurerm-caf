You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/app_gateway/100-simple-app-gateway/standalone

terraform init

terraform [plan | apply | destroy] \
  -var-file ../application.tfvars \
  -var-file ../configuration.tfvars \
  -var-file ../network_security_group_definition.tfvars


```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/landingzones/caf_example \
  -var-folder  /tf/caf/examples/app_gateway/100-simple-app-gateway/standalone \
  -level level1 \
  -a [plan | apply | destroy]

```