You can test this module outside of a landingzone using

```
cd /tf/caf/examples/compute/kubernetes_services/104-private-cluster/standalone

terraform init

terraform plan \
  -var-file ../acr.tfvars \
  -var-file ../aks.tfvars \
  -var-file ../configuration.tfvars \
  -var-file ../keyvault.tfvars  \
  -var-file ../networking.tfvars  \
  -var-file ../vm.tfvars

Note : Change the custom_data path in the configuration file of the VM, relative to the path currently you are in. It wil error out otherwise.
```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/examples/compute/kubernetes_services/104-private-cluster/ \
  -level level1 \
  -a plan

```