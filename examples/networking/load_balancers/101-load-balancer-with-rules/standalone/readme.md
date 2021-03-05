You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/networking/load_balancers/101-load-balancer-with-rules/standalone

terraform init

terraform plan \
  -var-file ../configuration.tfvars


```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/examples/networking/load_balancers/101-load-balancer-with-rules/ \
  -level level1 \
  -a plan

```