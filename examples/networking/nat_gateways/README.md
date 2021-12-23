module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# nat_gateway

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the NAT Gateway. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|False|
|idle_timeout_in_minutes| The idle timeout which should be used in minutes. Defaults to `4`.||False|
|public_ip_address_ids| A list of Public IP Address ID's which should be associated with the NAT Gateway resource.||False|
|public_ip_prefix_ids| / **Deprecated in favour of `azurerm_nat_gateway_public_ip_prefix_association`**) A list of Public IP Prefix ID's which should be associated with the NAT Gateway resource.||False|
|sku_name| The SKU which should be used. At this time the only supported value is `Standard`. Defaults to `Standard`.||False|
|tags| A mapping of tags to assign to the resource. Changing this forces a new resource to be created.||False|
|zones| A list of availability zones where the NAT Gateway should be provisioned. Changing this forces a new resource to be created.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the NAT Gateway.|||
|resource_guid|The resource GUID property of the NAT Gateway.|||
