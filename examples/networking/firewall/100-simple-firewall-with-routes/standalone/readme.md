You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/networking/firewall/100-simple-firewall-with-routes/standalone/

terraform init

terraform plan \
  -var-file ../configuration.tfvars 

```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/examples/networking/firewall/100-simple-firewall-with-routes/standalone/ \
  -level level1 \
  -a plan

```