module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# virtual_network_gateway

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the Virtual Network Gateway. Changing the name||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|type| The type of the Virtual Network Gateway. Valid options are||True|
|vpn_type| The routing type of the Virtual Network Gateway. Valid||False|
|enable_bgp| If `true`, BGP (Border Gateway Protocol) will be enabled||False|
|active_active| If `true`, an active-active Virtual Network Gateway||False|
|private_ip_address_enabled| Should private IP be enabled on this gateway for connections? Changing this forces a new resource to be created.||False|
|default_local_network_gateway_id| The ID of the local network gateway||False|
|sku| Configuration of the size and capacity of the virtual network||True|
|generation| The Generation of the Virtual Network gateway. Possible values include `Generation1`, `Generation2` or `None`.||False|
|ip_configuration|| Block |False|
|vpn_client_configuration|| Block |False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|ip_configuration|name| A user-defined name of the IP configuration. Defaults to|||False|
|ip_configuration|private_ip_address_allocation| Defines how the private IP address|||False|
|ip_configuration|subnet_id| The ID of the gateway subnet of a virtual network in|||True|
|ip_configuration|public_ip_address_id| The ID of the public ip address to associate|||True|
|vpn_client_configuration|address_space| The address space out of which ip addresses for|||True|
|vpn_client_configuration|aad_tenant| AzureAD Tenant URL|||False|
|vpn_client_configuration|aad_audience| The client id of the Azure VPN application.|||False|
|vpn_client_configuration|aad_issuer| The STS url for your tenant|||False|
|vpn_client_configuration|root_certificate| One or more `root_certificate` blocks which are|||False|
|root_certificate|name| A user-defined name of the root certificate.|||True|
|root_certificate|public_cert_data| The public certificate of the root certificate|||True|
|vpn_client_configuration|revoked_certificate| One or more `revoked_certificate` blocks which|||False|
|vpn_client_configuration|radius_server_address| The address of the Radius server.|||False|
|vpn_client_configuration|radius_server_secret| The secret used by the Radius server.|||False|
|vpn_client_configuration|vpn_client_protocols| List of the protocols supported by the vpn client.|||False|
|vpn_client_configuration|vpn_auth_types| List of the vpn authentication types for the virtual network gateway.|||False|
|vpn_client_configuration|vpn_auth_types| List of the vpn authentication types for the virtual network gateway.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Virtual Network Gateway.|||
|bgp_settings|A block of `bgp_settings`.|||
