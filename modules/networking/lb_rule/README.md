module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# lb_rule

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the LB Rule.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|loadbalancer_id| The ID of the Load Balancer in which to create the Rule.||True|
|frontend_ip_configuration_name| The name of the frontend IP configuration to which the rule is associated.||True|
|protocol| The transport protocol for the external endpoint. Possible values are `Tcp`, `Udp` or `All`.||True|
|frontend_port| The port for the external endpoint. Port numbers for each Rule must be unique within the Load Balancer. Possible values range between 0 and 65534, inclusive.||True|
|backend_port| The port used for internal connections on the endpoint. Possible values range between 0 and 65535, inclusive.||True|
|backend_address_pool_ids| A list of reference to a Backend Address Pool over which this Load Balancing Rule operates.||False|
|probe_id| A reference to a Probe used by this Load Balancing Rule.||False|
|enable_floating_ip| Are the Floating IPs enabled for this Load Balncer Rule? A "floating” IP is reassigned to a secondary server in case the primary server fails. Required to configure a SQL AlwaysOn Availability Group. Defaults to `false`.||False|
|idle_timeout_in_minutes| Specifies the idle timeout in minutes for TCP connections. Valid values are between `4` and `30` minutes. Defaults to `4` minutes.||False|
|load_distribution| Specifies the load balancing distribution type to be used by the Load Balancer. Possible values are: `Default` – The load balancer is configured to use a 5 tuple hash to map traffic to available servers. `SourceIP` – The load balancer is configured to use a 2 tuple hash to map traffic to available servers. `SourceIPProtocol` – The load balancer is configured to use a 3 tuple hash to map traffic to available servers. Also known as Session Persistence, where  the options are called `None`, `Client IP` and `Client IP and Protocol` respectively.||False|
|disable_outbound_snat| Is snat enabled for this Load Balancer Rule? Default `false`.||False|
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
|id|The ID of the Load Balancer Rule.|||
