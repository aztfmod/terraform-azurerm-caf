You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/mysql_server/103-private-endpoint-with-fw-rule-mysql/standalone

terraform init

terraform plan \
  -var-file ../configuration.tfvars 

```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/examples/mysql_server/103-private-endpoint-with-fw-rule-mysql/\
  -level level1 \
  -a plan

```