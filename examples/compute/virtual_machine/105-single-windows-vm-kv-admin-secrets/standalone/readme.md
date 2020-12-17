You can test this module outside of a landingzone using

```bash
cd /tf/caf/aztfmod/examples/compute/virtual_machine/105-single-windows-vm-kv-admin-secrets/standalone

terraform init

terraform plan \
  -var-file ../configuration.tfvars


```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/aztfmod/examples/compute/virtual_machine/105-single-windows-vm-kv-admin-secrets \
  -level level1 \
  -a plan

```