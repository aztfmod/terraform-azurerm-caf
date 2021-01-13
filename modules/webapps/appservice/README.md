# Azure App Service
This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_appservice" {
  source  = "aztfmod/caf/azurerm//modules/webapps/appservice"
  version = "4.21.2"
  # insert the 11 required variables here
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| azurecaf | n/a |
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app\_service\_plan\_id | n/a | `any` | n/a | yes |
| app\_settings | n/a | `any` | `null` | no |
| application\_insight | n/a | `any` | `null` | no |
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map` | n/a | yes |
| connection\_strings | n/a | `map` | `{}` | no |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| identity | n/a | `any` | `null` | no |
| location | (Required) Resource Location | `any` | n/a | yes |
| name | (Required) Name of the App Service | `any` | n/a | yes |
| resource\_group\_name | (Required) Resource group of the App Service | `any` | n/a | yes |
| settings | n/a | `any` | n/a | yes |
| slots | n/a | `map` | `{}` | no |
| tags | (Required) map of tags for the deployment | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| default\_site\_hostname | The Default Hostname associated with the App Service |
| id | The ID of the App Service. |
| outbound\_ip\_addresses | A comma separated list of outbound IP addresses |
| possible\_outbound\_ip\_addresses | A comma separated list of outbound IP addresses. not all of which are necessarily in use |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->