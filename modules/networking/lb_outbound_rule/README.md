module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# lb_outbound_rule

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Outbound Rule. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|loadbalancer_id| The ID of the Load Balancer in which to create the Outbound Rule. Changing this forces a new resource to be created.||True|
|frontend_ip_configuration| One or more `frontend_ip_configuration` blocks as defined below.| Block |True|
|backend_address_pool_id| The ID of the Backend Address Pool. Outbound traffic is randomly load balanced across IPs in the backend IPs.||True|
|protocol| The transport protocol for the external endpoint. Possible values are `Udp`, `Tcp` or `All`.||True|
|enable_tcp_reset| Receive bidirectional TCP Reset on TCP flow idle timeout or unexpected connection termination. This element is only used when the protocol is set to TCP.||False|
|allocated_outbound_ports| The number of outbound ports to be used for NAT.||False|
|idle_timeout_in_minutes| The timeout for the TCP idle connection||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|frontend_ip_configuration|name| The name of the Frontend IP Configuration.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Load Balancer Outbound Rule.|||
