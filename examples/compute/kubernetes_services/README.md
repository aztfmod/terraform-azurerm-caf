# Azure Kubernetes Services

This sub module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this module inside your Terraform code either as a module or as a sub module directly from the [Terraform Registry](https://registry.terraform.io/modules/aztfmod/caf/azurerm/latest) using the following calls:

Complete module:
```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "4.21.2"
  # insert the 6 required variables here
}
```
## Example scenarios

The following examples are available:

| Scenario                                     | Description                                                                                      |
|----------------------------------------------|--------------------------------------------------------------------------------------------------|
| [101-single-cluster](./101-single-cluster)   | Simple example for AKS cluster with public IP load balancer.                                     |
| [102-multi-nodepools](./102-multi-nodepools) | Simple example for AKS cluster with public IP load balancer and multiple node pools.             |
| [103-multi-clusters](./103-multi-clusters)   | Simple example for multi regions AKS clusters with public IP load balancer, multiple node pools. |
| [104-private-cluster](./104-private-cluster) | Simple example for private AKS clusters.                                                         |

## Run this example

You can run this example directly using Terraform or via rover:

### With Terraform

```bash
#Login to your Azure subscription
az login

#Run the example
cd /tf/caf/examples/compute/kubernetes_services/101-single-cluster/standalone

terraform init

terraform [plan | apply | destroy] \
  -var-file ../aks.tfvars \
  -var-file ../networking.tfvars
```

### With rover

To test this deployment in the example landingzone, make sure the launchpad has been deployed first, then run the following command:

```bash
rover \
  -lz /tf/caf/landingzones/caf_example \
  -var-folder  /tf/caf/modules/aks/examples/101-single-cluster/ \
  -level level1 \
  -a [plan | apply | destroy]
```