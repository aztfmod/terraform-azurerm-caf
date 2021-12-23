module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# dedicated_host

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of this Dedicated Host. Changing this forces a new resource to be created.||True|
|dedicated_host_group|The `dedicated_host_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|sku_name| Specify the sku name of the Dedicated Host. Possible values are `DSv3-Type1`, `DSv3-Type2`, `DSv4-Type1`, `ESv3-Type1`, `ESv3-Type2`,`FSv2-Type2`, `DASv4-Type1`, `DCSv2-Type1`, `DDSv4-Type1`, `DSv3-Type1`, `DSv3-Type2`, `DSv3-Type3`, `DSv4-Type1`, `EASv4-Type1`, `EDSv4-Type1`, `ESv3-Type1`, `ESv3-Type2`, `ESv3-Type3`, `ESv4-Type1`, `FSv2-Type2`, `FSv2-Type3`, `LSv2-Type1`, `MS-Type1`, `MSm-Type1`, `MSmv2-Type1`, `MSv2-Type1`, `NVASv4-Type1`, and `NVSv3-Type1`. Changing this forces a new resource to be created.||True|
|platform_fault_domain| Specify the fault domain of the Dedicated Host Group in which to create the Dedicated Host. Changing this forces a new resource to be created.||True|
|auto_replace_on_failure| Should the Dedicated Host automatically be replaced in case of a Hardware Failure? Defaults to `true`.||False|
|license_type| Specifies the software license type that will be applied to the VMs deployed on the Dedicated Host. Possible values are `None`, `Windows_Server_Hybrid` and `Windows_Server_Perpetual`. Defaults to `None`.||False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|dedicated_host_group| key | Key for  dedicated_host_group||| Required if  |
|dedicated_host_group| lz_key |Landing Zone Key in wich the dedicated_host_group is located|||True|
|dedicated_host_group| id | The id of the dedicated_host_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Dedicated Host.|||
