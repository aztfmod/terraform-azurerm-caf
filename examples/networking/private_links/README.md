module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# private_link_service

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of this Private Link Service. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|nat_ip_configuration| One or more (up to 8) `nat_ip_configuration` block as defined below.| Block |True|
|load_balancer_frontend_ip_configuration_ids| A list of Frontend IP Configuration ID's from a Standard Load Balancer, where traffic from the Private Link Service should be routed. You can use Load Balancer Rules to direct this traffic to appropriate backend pools where your applications are running.||True|
|auto_approval_subscription_ids| A list of Subscription UUID/GUID's that will be automatically be able to use this Private Link Service.||False|
|enable_proxy_protocol| Should the Private Link Service support the Proxy Protocol? Defaults to `false`.||False|
|tags| A mapping of tags to assign to the resource. Changing this forces a new resource to be created.||False|
|visibility_subscription_ids| A list of Subscription UUID/GUID's that will be able to see this Private Link Service.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|nat_ip_configuration|name| Specifies the name which should be used for the NAT IP Configuration. Changing this forces a new resource to be created.|||True|
|nat_ip_configuration|subnet_id| Specifies the ID of the Subnet which should be used for the Private Link Service.|||True|
|nat_ip_configuration|primary| Is this is the Primary IP Configuration? Changing this forces a new resource to be created.|||True|
|nat_ip_configuration|private_ip_address| Specifies a Private Static IP Address for this IP Configuration.|||False|
|nat_ip_configuration|private_ip_address_version| The version of the IP Protocol which should be used. At this time the only supported value is `IPv4`. Defaults to `IPv4`.|||False|

## Outputs
| Name | Description |
|------|-------------|
|alias|A globally unique DNS Name for your Private Link Service. You can use this alias to request a connection to your Private Link Service.|||
