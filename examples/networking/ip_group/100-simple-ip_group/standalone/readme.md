You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/networking/ip_group/100-simple-ip_group/standalone/
parameter_files=$(find .. | grep .tfvars | sed 's/.*/-var-file &/' | xargs)
terraform init

eval terraform plan ${parameter_files}

```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/examples/networking/ip_group/100-simple-ip_group/standalone/ \
  -level level1 \
  -a plan

```