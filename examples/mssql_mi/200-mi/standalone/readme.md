You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/mssql_mi/200-mi/standalone

terraform init

terraform plan \
  -var-file ../configuration.tfvars \
  -var-file ../nsg.tfvars





```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/examples/mssql_mi/200-mi/ \
  -level level1 \
  -a plan

```