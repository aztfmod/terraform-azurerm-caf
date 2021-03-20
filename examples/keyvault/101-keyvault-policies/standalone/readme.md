You can test this module outside of a landingzone using

```bash
cd /tf/caf/aztfmod/examples/keyvault/101-keyvault-policies/standalone

terraform init

terraform [plan|apply|delete] \
  -var-file ../configuration.tfvars \
  -var-file ../keyvaults.tfvars


```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/landingzones/caf_example \
  -tfstate example-101-keyvault-policies.tfstate \
  -var-folder /tf/caf/aztfmod/examples/keyvault/101-keyvault-policies \
  -level level1 \
  -a [plan|apply|delete]

```