module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# app_service_environment

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the App Service Environment. Changing this forces a new resource to be created. ||True|
|subnet|The `subnet` block as defined below.|Block|True|
|cluster_setting| Zero or more `cluster_setting` blocks as defined below. | Block |False|
|internal_load_balancing_mode| Specifies which endpoints to serve internally in the Virtual Network for the App Service Environment. Possible values are `None`, `Web`, `Publishing` and combined value `"Web, Publishing"`. Defaults to `None`.||False|
|pricing_tier| Pricing tier for the front end instances. Possible values are `I1`, `I2` and `I3`. Defaults to `I1`.||False|
|front_end_scale_factor| Scale factor for front end instances. Possible values are between `5` and `15`. Defaults to `15`.||False|
|allowed_user_ip_cidrs| Allowed user added IP ranges on the ASE database. Use the addresses you want to set as the explicit egress address ranges.||False|
|allowed_user_ip_cidrs| Allowed user added IP ranges on the ASE database. Use the addresses you want to set as the explicit egress address ranges.||False|
|resource_group|The `resource_group` block as defined below.|Block|False|
|tags| A mapping of tags to assign to the resource. Changing this forces a new resource to be created. ||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|subnet| key | Key for  subnet||| Required if  |
|subnet| lz_key |Landing Zone Key in wich the subnet is located|||True|
|subnet| id | The id of the subnet |||True|
|cluster_setting|name| The name of the Cluster Setting. |||True|
|cluster_setting|value| The value for the Cluster Setting. |||True|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||False|
|resource_group| name | The name of the resource_group |||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the App Service Environment.|||
|internal_ip_address|IP address of internal load balancer of the App Service Environment.|||
|location|The location where the App Service Environment exists.|||
|outbound_ip_addresses|List of outbound IP addresses of the App Service Environment.|||
|service_ip_address|IP address of service endpoint of the App Service Environment.|||
