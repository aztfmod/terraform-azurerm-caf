[![VScodespaces](https://img.shields.io/endpoint?url=https%3A%2F%2Faka.ms%2Fvso-badge)](https://online.visualstudio.com/environments/new?name=terraform-azurerm-caf-aad-apps&repo=aztfmod/terraform-azurerm-caf-aad-apps)
[![Gitter](https://badges.gitter.im/aztfmod/community.svg)](https://gitter.im/aztfmod/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

# Creates an Azure AD Application Registration

Creates an Azure AD application registration and stores its secrets to an Azure Key Vault.

<!--- BEGIN_TF_DOCS --->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azuread | n/a |
| azurecaf | n/a |
| azurerm | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aad\_api\_permission | Object to provide API access to an Azure Active Directory application | <pre>map(object({<br>    resource_app_id = string<br>    rsource_access = map(object({<br>      id   = string<br>      type = string<br>    }))<br>  }))</pre> | `{}` | no |
| aad\_api\_permissions | Map of aad\_api\_permission objects to provide API access to an Azure Active Directory application | `any` | n/a | yes |
| aad\_app | Object to create Azure Active Directory application | <pre>object({<br>    convention              = string<br>    useprefix               = bool<br>    application_name        = string<br>    password_expire_in_days = number<br><br>    keyvault = object({<br>      keyvault_key            = string<br>      key_permissions         = list(string)<br>      secret_permissions      = list(string)<br>      storage_permissions     = list(string)<br>      certificate_permissions = list(string)<br>    })<br><br>  })</pre> | <pre>{<br>  "application_name": null,<br>  "convention": "cafrandom",<br>  "keyvault": null,<br>  "password_expire_in_days": 180,<br>  "useprefix": false<br>}</pre> | no |
| aad\_apps | Map of aad\_app objects to create Azure Active Directory applications | `any` | n/a | yes |
| keyvaults | Map of deployed azurerm\_key\_vault | `any` | n/a | yes |
| prefix | Prefixes to be used in the name of the App registration | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aad\_apps | Output the full Azure AD application registration object. |

<!--- END_TF_DOCS --->