# Azure Kubernetes Services

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_aks" {
  source  = "aztfmod/caf/azurerm//modules/compute/aks"
  version = "4.21.2"
  # insert the 8 required variables here
}
```

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