You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/recovery_vault/103-asr-with-private-endpoint/standalone

terraform init

terraform plan \
  -var-file ../configuration.tfvars \
  -var-file ../private_dns.tfvars \
  -var-file ../private_endpoints.tfvars\
  -var-file ../recovery_vaults.tfvars\
  -var-file ../virtual_networks.tfvars

```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/examples/recovery_vault/103-asr-with-private-endpoint/ \
  -level level1 \
  -a plan

```