You can test this module outside of a landingzone using

```
cd /tf/caf/aztfmod/examples/compute/container_groups/101-aci-public/standalone

terraform init

terraform [plan | apply | destroy] \
  -var-file ../container_groups.tfvars \
  -var-file ../global_settings.tfvars \
  -var-file ../resource_groups.tfvars \
  -var-file ../keyvaults.tfvars \
  -var-file ../managed_identities.tfvars


```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -level level1 \
  -a [plan | apply | destroy]

```