You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/networking/private_links/endpoints/centralized/standalone

terraform init

terraform plan \
  -var-file ../configuration.tfvars \
  -var-file ./private_endpoints.tfvars \
  -var-file ../diagnostic_storage_accounts.tfvars \
  -var-file ../keyvaults.tfvars \
  -var-file ../eventhub_namespaces.tfvars \
  -var-file ../virtual_networks.tfvars \
  -var-file ../storage_accounts.tfvars

```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/examples \
  -var-folder /tf/caf/examples/networking/private_links/endpoints/centralized \
  -level level1 \
  -a plan
  
```