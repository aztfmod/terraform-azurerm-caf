module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# virtual_wan

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Virtual WAN. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|disable_vpn_encryption| Boolean flag to specify whether VPN encryption is disabled. Defaults to `false`.||False|
|allow_branch_to_branch_traffic| Boolean flag to specify whether branch to branch traffic is allowed. Defaults to `true`.||False|
|office365_local_breakout_category| Specifies the Office365 local breakout category. Possible values include: `Optimize`, `OptimizeAndAllow`, `All`, `None`. Defaults to `None`.||False|
|type| Specifies the Virtual WAN type. Possible Values include: `Basic` and `Standard`. Defaults to `Standard`.||False|
|tags| A mapping of tags to assign to the Virtual WAN.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Virtual WAN.|||
