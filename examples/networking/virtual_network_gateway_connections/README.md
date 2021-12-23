module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# virtual_network_gateway_connection

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the connection. Changing the name forces a||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|type| The type of connection. Valid options are `IPsec`||True|
|virtual_network_gateway|The `virtual_network_gateway` block as defined below.|Block|True|
|authorization_key| The authorization key associated with the||False|
|dpd_timeout_seconds| The dead peer detection timeout of this connection in seconds. Changing this forces a new resource to be created.||False|
|express_route_circuit|The `express_route_circuit` block as defined below.|Block|False|
|peer_virtual_network_gateway_id| The ID of the peer virtual||False|
|local_azure_ip_address_enabled| Use private local Azure IP for the connection. Changing this forces a new resource to be created.||False|
|local_network_gateway|The `local_network_gateway` block as defined below.|Block|False|
|routing_weight| The routing weight. Defaults to `10`.||False|
|shared_key| The shared IPSec key. A key could be provided if a||False|
|connection_protocol| The IKE protocol version to use. Possible||False|
|enable_bgp| If `true`, BGP (Border Gateway Protocol) is enabled||False|
|express_route_gateway_bypass| If `true`, data packets will bypass ExpressRoute Gateway for data forwarding This is only valid for ExpressRoute connections.||False|
|use_policy_based_traffic_selectors| If `true`, policy-based traffic||False|
|ipsec_policy|| Block |False|
|traffic_selector_policy|||False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|virtual_network_gateway| key | Key for  virtual_network_gateway||| Required if  |
|virtual_network_gateway| lz_key |Landing Zone Key in wich the virtual_network_gateway is located|||True|
|virtual_network_gateway| id | The id of the virtual_network_gateway |||True|
|express_route_circuit| key | Key for  express_route_circuit||| Required if  |
|express_route_circuit| lz_key |Landing Zone Key in wich the express_route_circuit is located|||False|
|express_route_circuit| id | The id of the express_route_circuit |||False|
|local_network_gateway| key | Key for  local_network_gateway||| Required if  |
|local_network_gateway| lz_key |Landing Zone Key in wich the local_network_gateway is located|||False|
|local_network_gateway| id | The id of the local_network_gateway |||False|
|ipsec_policy|dh_group| The DH group used in IKE phase 1 for initial SA. Valid|||True|
|ipsec_policy|ike_encryption| The IKE encryption algorithm. Valid|||True|
|ipsec_policy|ike_integrity| The IKE integrity algorithm. Valid|||True|
|ipsec_policy|ipsec_encryption| The IPSec encryption algorithm. Valid|||True|
|ipsec_policy|ipsec_integrity| The IPSec integrity algorithm. Valid|||True|
|ipsec_policy|pfs_group| The DH group used in IKE phase 2 for new child SA.|||True|
|ipsec_policy|sa_datasize| The IPSec SA payload size in KB. Must be at least|||False|
|ipsec_policy|sa_lifetime| The IPSec SA lifetime in seconds. Must be at least|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Virtual Network Gateway Connection.|||
