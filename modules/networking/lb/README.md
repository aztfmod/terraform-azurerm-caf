module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# lb

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Load Balancer.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|frontend_ip_configuration| One or multiple `frontend_ip_configuration` blocks as documented below.||False|
|sku| The SKU of the Azure Load Balancer. Accepted values are `Basic`, `Standard` and `Gateway`. Defaults to `Basic`.||False|
|sku_tier| `sku_tier` - (Optional) The Sku Tier of this Load Balancer. Possible values are `Global` and `Regional`. Defaults to `Regional`. Changing this forces a new resource to be created.||False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The Load Balancer ID.|||
|frontend_ip_configuration|A `frontend_ip_configuration` block as documented below.|||
|private_ip_address|The first private IP address assigned to the load balancer in `frontend_ip_configuration` blocks, if any.|||
|private_ip_addresses|The list of private IP address assigned to the load balancer in `frontend_ip_configuration` blocks, if any.|||
