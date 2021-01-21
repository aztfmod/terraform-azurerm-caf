# Azure Kubernetes Services

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

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
  -lz /tf/caf/aztfmod/examples \
  -var-folder  /tf/caf/modules/aks/examples/101-single-cluster/ \
  -level level1 \
  -a [plan | apply | destroy]
```

## References

Below are the input and output references:
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurecaf | n/a |
| azurerm | n/a |
| null | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_group\_ids | n/a | `any` | n/a | yes |
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map` | n/a | yes |
| diagnostic\_profiles | n/a | `any` | `null` | no |
| diagnostics | n/a | `any` | n/a | yes |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| resource\_group | n/a | `any` | n/a | yes |
| settings | n/a | `any` | n/a | yes |
| subnets | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aks\_kubeconfig\_admin\_cmd | n/a |
| aks\_kubeconfig\_cmd | n/a |
| cluster\_name | n/a |
| enable\_rbac | n/a |
| id | n/a |
| identity | System assigned identity which is used by master components |
| kube\_admin\_config | n/a |
| kube\_admin\_config\_raw | n/a |
| kube\_config | n/a |
| kubelet\_identity | User-defined Managed Identity assigned to the Kubelets |
| node\_resource\_group | n/a |
| private\_fqdn | n/a |
| rbac\_id | n/a |
| resource\_group\_name | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->