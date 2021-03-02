You can test this module outside of a landingzone using

```
cd /tf/caf/examples/compute/kubernetes_services/101-single-cluster/standalone

terraform init

terraform [plan | apply | destroy] \
  -var-file ../aks.tfvars \
  -var-file ../networking.tfvars


terraform apply \
  -var-file ../aks.tfvars \
  -var-file ../networking.tfvars \
  -var-file ../diagnostics.tfvars
```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/examples/compute/kubernetes_services/101-single-cluster/ \
  -level level1 \
  -a [plan | apply | destroy]

```