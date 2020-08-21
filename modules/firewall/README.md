[![VScodespaces](https://img.shields.io/endpoint?url=https%3A%2F%2Faka.ms%2Fvso-badge)](https://online.visualstudio.com/environments/new?name=terraform-azurerm-caf-azure-firewall&repo=terraform-azurerm-caf-azure-firewall)
[![Gitter](https://badges.gitter.im/aztfmod/community.svg)](https://gitter.im/aztfmod/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

# Deploys Azure Firewall
Creates an Azure Firewall in a given region


Reference the module to a specific version (recommended):
```hcl
module "az_firewall" {
  source  = "aztfmod/caf-azure-firewall/azurerm"
  version = "0.x.y"

  convention                  = local.convention
  name                        = local.az_fw_config.name
  resource_group_name         = azurerm_resource_group.rg_test.name
  location                    = local.location 
  tags                        = local.tags
  la_workspace_id             = module.la_test.id
  diagnostics_map             = module.diags_test.diagnostics_map
  diagnostics_settings        = local.az_fw_config.diagnostics

  subnet_id                   = lookup(module.vnet_test.vnet_subnets, "AzureFirewallSubnet", null)
  public_ip_id                = module.public_ip_test.id
}
```

<!--- BEGIN_TF_DOCS --->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurecaf | n/a |
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| convention | (Required) Naming convention method to use | `any` | n/a | yes |
| diagnostics\_map | (Required) Storage Account and Event Hub data for the AzFW diagnostics | `any` | n/a | yes |
| diagnostics\_settings | (Required) Map with the diagnostics settings for AzFW deployment | `any` | n/a | yes |
| la\_workspace\_id | (Required) ID of Log Analytics data for the AzFW diagnostics | `any` | n/a | yes |
| location | (Required) Location of the Azure Firewall to be created | `any` | n/a | yes |
| max\_length | (Optional) You can speficy a maximum length to the name of the resource | `string` | `"50"` | no |
| name | (Required) Name of the Azure Firewall to be created | `any` | n/a | yes |
| postfix | (Optional) You can use a postfix to the name of the resource | `string` | `""` | no |
| prefix | (Optional) You can use a prefix to the name of the resource | `string` | `""` | no |
| public\_ip\_id | (Required) Public IP address identifier. IP address must be of type static and standard. | `any` | n/a | yes |
| resource\_group\_name | (Required) Resource Group of the Azure Firewall to be created | `any` | n/a | yes |
| subnet\_id | (Required) ID for the subnet where to deploy the Azure Firewall | `any` | n/a | yes |
| tags | (Required) Tags of the Azure Firewall to be created | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| az\_firewall\_config | Outputs a map with az\_fw\_name,az\_fw\_id,az\_ipconfig,az\_object - to be deprecated in future version |
| id | Output the object ID |
| name | Output the object name |
| object | Output the full object |

<!--- END_TF_DOCS --->