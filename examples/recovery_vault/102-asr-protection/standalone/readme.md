You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/recovery_vault/102-asr-protection/standalone

terraform init

terraform plan \
  -var-file ../configuration.tfvars 

```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/examples/recovery_vault/102-asr-protection/ \
  -level level1 \
  -a plan

```