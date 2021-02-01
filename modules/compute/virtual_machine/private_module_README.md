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
| external | n/a |
| random | n/a |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| availability\_sets | n/a | `map` | `{}` | no |
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map` | n/a | yes |
| boot\_diagnostics\_storage\_account | (Optional) The Primary/Secondary Endpoint for the Azure Storage Account (general purpose) which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor. | `map` | `{}` | no |
| client\_config | Client configuration object (see module README.md). | `any` | n/a | yes |
| diagnostics | n/a | `map` | `{}` | no |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| keyvaults | Keyvault to store the SSH public and private keys when not provided by the var.public\_key\_pem\_file or retrieve admin username and password | `string` | `""` | no |
| location | (Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| managed\_identities | n/a | `map` | `{}` | no |
| proximity\_placement\_groups | n/a | `map` | `{}` | no |
| public\_ip\_addresses | n/a | `map` | `{}` | no |
| public\_key\_pem\_file | If disable\_password\_authentication is set to true, ssh authentication is enabled. You can provide a list of file path of the public ssh key in PEM format. If left blank a new RSA/4096 key is created and the key is stored in the keyvault\_id. The secret name being the {computer name}-ssh-public and {computer name}-ssh-private | `string` | `""` | no |
| recovery\_vaults | n/a | `map` | `{}` | no |
| resource\_group\_name | Name of the existing resource group to deploy the virtual machine | `any` | n/a | yes |
| settings | n/a | `any` | n/a | yes |
| vnets | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| admin\_username | Local admin username |
| id | n/a |
| internal\_fqdns | n/a |
| os\_type | n/a |
| ssh\_keys | n/a |
| winrm | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->