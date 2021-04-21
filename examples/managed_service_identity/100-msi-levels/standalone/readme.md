You can test this module outside of a landingzone using

```bash
cd /tf/caf/aztfmod/examples/managed_service_identity/101-msi-levels/standalone

terraform init

terraform [plan|apply|delete] \
  -var-file ../configuration.tfvars


```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/landingzones/caf_example \
  -tfstate example-101-msi-levels.tfstate \
  -var-folder /tf/caf/aztfmod/examples/managed_service_identity/101-msi-levels \
  -level level1 \
  -a [plan|apply|delete]

```