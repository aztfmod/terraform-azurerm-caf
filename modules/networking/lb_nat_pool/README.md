module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# lb_nat_pool

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the NAT pool.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|loadbalancer_id| The ID of the Load Balancer in which to create the NAT pool.||True|
|frontend_ip_configuration_name| The name of the frontend IP configuration exposing this rule.||True|
|protocol| The transport protocol for the external endpoint. Possible values are `Udp` or `Tcp`.||True|
|frontend_port_start| The first port number in the range of external ports that will be used to provide Inbound Nat to NICs associated with this Load Balancer. Possible values range between 1 and 65534, inclusive.||True|
|frontend_port_end| The last port number in the range of external ports that will be used to provide Inbound Nat to NICs associated with this Load Balancer. Possible values range between 1 and 65534, inclusive.||True|
|backend_port| The port used for the internal endpoint. Possible values range between 1 and 65535, inclusive.||True|
|idle_timeout_in_minutes| Specifies the idle timeout in minutes for TCP connections. Valid values are between `4` and `30`. Defaults to `4`.||False|
|floating_ip_enabled| Are the floating IPs enabled for this Load Balancer Rule? A floating IP is reassigned to a secondary server in case the primary server fails. Required to configure a SQL AlwaysOn Availability Group. Defaults to `false`.||False|
|tcp_reset_enabled| Is TCP Reset enabled for this Load Balancer Rule? Defaults to `false`.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Load Balancer NAT pool.|||
