module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# virtual_network

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the virtual network. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|address_space| The address space that is used the virtual network. You can supply more than one address space.||True|
| region |The region_key where the resource will be deployed|String|True|
|bgp_community| The BGP community attribute in format `<as-number>:<community-value>`.||False|
|ddos_protection_plan| A `ddos_protection_plan` block as documented below.| Block |False|
|dns_servers| List of IP addresses of DNS servers||False|
|flow_timeout_in_minutes| The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between `4` and `30` minutes.||False|
|subnet| Can be specified multiple times to define multiple subnets. Each `subnet` block supports fields documented below.| Block |False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|ddos_protection_plan|id| The ID of DDoS Protection Plan.|||True|
|ddos_protection_plan|enable| Enable/disable DDoS Protection Plan on Virtual Network.|||True|
|subnet|name| The name of the subnet.|||True|
|subnet|address_prefix| The address prefix to use for the subnet.|||True|
|subnet|security_group| The Network Security Group to associate with the subnet. (Referenced by `id`, ie. `azurerm_network_security_group.example.id`)|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The virtual NetworkConfiguration ID.|||
|name|The name of the virtual network.|||
|resource_group_name|The name of the resource group in which to create the virtual network.|||
|location|The location/region where the virtual network is created.|||
|address_space|The list of address spaces used by the virtual network.|||
|guid|The GUID of the virtual network.|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# subnet

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the subnet. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|virtual_network|The `virtual_network` block as defined below.|Block|True|
|address_prefix| The address prefix to use for the subnet.||False|
|address_prefixes| The address prefixes to use for the subnet.||False|
|delegation| One or more `delegation` blocks as defined below.| Block |False|
|enforce_private_link_endpoint_network_policies| Enable or Disable network policies for the private link endpoint on the subnet. Setting this to `true` will **Disable** the policy and setting this to `false` will **Enable** the policy. Default value is `false`.||False|
|enforce_private_link_service_network_policies| Enable or Disable network policies for the private link service on the subnet. Setting this to `true` will **Disable** the policy and setting this to `false` will **Enable** the policy. Default value is `false`.||False|
|service_endpoints| The list of Service endpoints to associate with the subnet. Possible values include: `Microsoft.AzureActiveDirectory`, `Microsoft.AzureCosmosDB`, `Microsoft.ContainerRegistry`, `Microsoft.EventHub`, `Microsoft.KeyVault`, `Microsoft.ServiceBus`, `Microsoft.Sql`, `Microsoft.Storage` and `Microsoft.Web`.||False|
|service_endpoint_policy_ids| The list of IDs of Service Endpoint Policies to associate with the subnet.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|virtual_network| key | Key for  virtual_network||| Required if  |
|virtual_network| lz_key |Landing Zone Key in wich the virtual_network is located|||True|
|virtual_network| name | The name of the virtual_network |||True|
|delegation|name||||False|
|delegation|service_delegation||||False|
|service_delegation|name| The name of service to delegate to. Possible values include `Microsoft.ApiManagement/service`, `Microsoft.AzureCosmosDB/clusters`, `Microsoft.BareMetal/AzureVMware`, `Microsoft.BareMetal/CrayServers`, `Microsoft.Batch/batchAccounts`, `Microsoft.ContainerInstance/containerGroups`, `Microsoft.ContainerService/managedClusters`, `Microsoft.Databricks/workspaces`, `Microsoft.DBforMySQL/flexibleServers`, `Microsoft.DBforMySQL/serversv2`, `Microsoft.DBforPostgreSQL/flexibleServers`, `Microsoft.DBforPostgreSQL/serversv2`, `Microsoft.DBforPostgreSQL/singleServers`, `Microsoft.HardwareSecurityModules/dedicatedHSMs`, `Microsoft.Kusto/clusters`, `Microsoft.Logic/integrationServiceEnvironments`, `Microsoft.MachineLearningServices/workspaces`, `Microsoft.Netapp/volumes`, `Microsoft.Network/managedResolvers`, `Microsoft.PowerPlatform/vnetaccesslinks`, `Microsoft.ServiceFabricMesh/networks`, `Microsoft.Sql/managedInstances`, `Microsoft.Sql/servers`, `Microsoft.StreamAnalytics/streamingJobs`, `Microsoft.Synapse/workspaces`, `Microsoft.Web/hostingEnvironments`, and `Microsoft.Web/serverFarms`.|||True|
|service_delegation|actions| A list of Actions which should be delegated. This list is specific to the service to delegate to. Possible values include `Microsoft.Network/networkinterfaces/*`, `Microsoft.Network/virtualNetworks/subnets/action`, `Microsoft.Network/virtualNetworks/subnets/join/action`, `Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action` and `Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action`.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The subnet ID.|||
|name|The name of the subnet.|||
|resource_group_name|The name of the resource group in which the subnet is created in.|||
|virtual_network_name|The name of the virtual network in which the subnet is created in|||
|address_prefix| The address prefix for the subnet|||
|address_prefixes|The address prefixes for the subnet|||
