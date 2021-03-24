You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/networking/load_balancers/102-internal-load-balancer/standalone

terraform init

terraform plan \
  -var-file ../configuration.tfvars


```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/landingzones/caf_example \
  -var-folder  /tf/caf/examples/networking/load_balancers/102-internal-load-balancer/ \
  -level level1 \
  -a plan

```