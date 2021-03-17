You can test this module outside of a landingzone using

```bash
cd /tf/caf/aztfmod/examples/storage_accounts/100-simple-storage-account-blob-container/standalone

terraform init

terraform apply \
  -var-file ../configuration.tfvars \
  -var-file ../keyvaults.tfvars


```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/aztfmod/examples/storage_accounts/100-simple-storage-account-blob-container \
  -level level1 \
  -a plan

```