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


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# lb_nat_rule

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the NAT Rule.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|loadbalancer_id| The ID of the Load Balancer in which to create the NAT Rule.||True|
|frontend_ip_configuration_name| The name of the frontend IP configuration exposing this rule.||True|
|protocol| The transport protocol for the external endpoint. Possible values are `Udp`, `Tcp` or `All`.||True|
|frontend_port| The port for the external endpoint. Port numbers for each Rule must be unique within the Load Balancer. Possible values range between 1 and 65534, inclusive.||True|
|backend_port| The port used for internal connections on the endpoint. Possible values range between 1 and 65535, inclusive.||True|
|idle_timeout_in_minutes| Specifies the idle timeout in minutes for TCP connections. Valid values are between `4` and `30` minutes. Defaults to `4` minutes.||False|
|enable_floating_ip| Are the Floating IPs enabled for this Load Balancer Rule? A "floating� IP is reassigned to a secondary server in case the primary server fails. Required to configure a SQL AlwaysOn Availability Group. Defaults to `false`.||False|
|enable_tcp_reset| Is TCP Reset enabled for this Load Balancer Rule? Defaults to `false`.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Load Balancer NAT Rule.|||
