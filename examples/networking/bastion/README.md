module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# bastion_host

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Bastion Host. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|sku| The SKU of the Bastion Host. Accepted values are `Basic` and `Standard`. Defaults to `Basic`.||False|
|ip_configuration| A `ip_configuration` block as defined below.| Block |True|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|ip_configuration|name| The name of the IP configuration.|||True|
|ip_configuration|subnet_id| Reference to a subnet in which this Bastion Host has been created.|||True|
|ip_configuration|public_ip_address_id||||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Bastion Host.|||
|dns_name|The FQDN for the Bastion Host.|||
