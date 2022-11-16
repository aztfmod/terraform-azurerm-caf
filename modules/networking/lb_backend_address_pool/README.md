module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# lb_backend_address_pool

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Backend Address Pool.||True|
|loadbalancer_id| The ID of the Load Balancer in which to create the Backend Address Pool.||True|
|tunnel_interface| One or more `tunnel_interface` blocks as defined below.| Block |False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|tunnel_interface|identifier| The unique identifier of this Gateway Lodbalancer Tunnel Interface.|||True|
|tunnel_interface|type| The traffic type of this Gateway Lodbalancer Tunnel Interface. Possible values are `Internal` and `External`.|||True|
|tunnel_interface|protocol| The protocol used for this Gateway Lodbalancer Tunnel Interface. Possible values are `Native` and `VXLAN`.|||True|
|tunnel_interface|port| The port number that this Gateway Lodbalancer Tunnel Interface listens to.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Backend Address Pool.|||
|backend_ip_configurations|The Backend IP Configurations associated with this Backend Address Pool.|||
|load_balancing_rules|The Load Balancing Rules associated with this Backend Address Pool.|||
|outbound_rules|An array of the Load Balancing Outbound Rules associated with this Backend Address Pool.|||
