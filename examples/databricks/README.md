module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# databricks_workspace

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Databricks Workspace resource. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|load_balancer_backend_address_pool_id| Resource ID of the Outbound Load balancer Backend Address Pool for Secure Cluster Connectivity (No Public IP) workspace. Changing this forces a new resource to be created.||False|
|sku| The `sku` to use for the Databricks Workspace. Possible values are `standard`, `premium`, or `trial`. Changing this can force a new resource to be created in some circumstances.||True|
|managed_services_cmk_key_vault_key_id| Customer managed encryption properties for the Databricks Workspace managed resources(e.g. Notebooks and Artifacts). Changing this forces a new resource to be created.||False|
|managed_resource_group_name| The name of the resource group where Azure should place the managed Databricks resources. Changing this forces a new resource to be created.||False|
|customer_managed_key_enabled| Is the workspace enabled for customer managed key encryption? If `true` this enables the Managed Identity for the managed storage account. Possible values are `true` or `false`. Defaults to `false`. This field is only valid if the Databricks Workspace `sku` is set to `premium`. Changing this forces a new resource to be created.||False|
|infrastructure_encryption_enabled`- (Optional) Is the Databricks File System root file system enabled with a secondary layer of encryption with platform managed keys? Possible values are `true|||False|
|public_network_access_enabled| Allow public access for accessing workspace. Set value to `false` to access workspace only via private link endpoint. Possible values include `true` or `false`. Defaults to `true`. Changing this forces a new resource to be created.||False|
|network_security_group_rules_required| Does the data plane (clusters) to control plane communication happen over private link endpoint only or publicly? Possible values `AllRules`, `NoAzureDatabricksRules` or `NoAzureServiceRules`. Required when `public_network_access_enabled` is set to `false`. Changing this forces a new resource to be created.||False|
|custom_parameters| A `custom_parameters` block as documented below.| Block |False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|custom_parameters|machine_learning_workspace_id| The ID of a Azure Machine Learning workspace to link with Databricks workspace. Changing this forces a new resource to be created.|||False|
|custom_parameters|nat_gateway_name| Name of the NAT gateway for Secure Cluster Connectivity (No Public IP) workspace subnets. Defaults to `nat-gateway`. Changing this forces a new resource to be created.|||False|
|custom_parameters|public_ip_name| Name of the Public IP for No Public IP workspace with managed vNet. Defaults to `nat-gw-public-ip`. Changing this forces a new resource to be created.|||False|
|custom_parameters|no_public_ip| Are public IP Addresses not allowed? Possible values are `true` or `false`. Defaults to `false`. Changing this forces a new resource to be created.|||False|
|custom_parameters|public_subnet_name| The name of the Public Subnet within the Virtual Network. Required if `virtual_network_id` is set. Changing this forces a new resource to be created.|||False|
|custom_parameters|public_subnet_network_security_group_association_id| The resource ID of the `azurerm_subnet_network_security_group_association` resource which is referred to by the `public_subnet_name` field. Required if `virtual_network_id` is set.|||False|
|custom_parameters|private_subnet_name| The name of the Private Subnet within the Virtual Network. Required if `virtual_network_id` is set. Changing this forces a new resource to be created.|||False|
|custom_parameters|private_subnet_network_security_group_association_id| The resource ID of the `azurerm_subnet_network_security_group_association` resource which is referred to by the `private_subnet_name` field. Required if `virtual_network_id` is set.|||False|
|custom_parameters|storage_account_name| Default Databricks File Storage account name. Defaults to a randomized name(e.g. `dbstoragel6mfeghoe5kxu`). Changing this forces a new resource to be created.|||False|
|custom_parameters|storage_account_sku_name| Storage account SKU name. Possible values include `Standard_LRS`, `Standard_GRS`, `Standard_RAGRS`, `Standard_GZRS`, `Standard_RAGZRS`, `Standard_ZRS`, `Premium_LRS` or `Premium_ZRS`. Defaults to `Standard_GRS`. Changing this forces a new resource to be created.|||False|
|custom_parameters|virtual_network_id| The ID of a Virtual Network where this Databricks Cluster should be created. Changing this forces a new resource to be created.|||False|
|custom_parameters|vnet_address_prefix| Address prefix for Managed virtual network. Defaults to `10.139`. Changing this forces a new resource to be created.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Databricks Workspace in the Azure management plane.|||
|managed_resource_group_id|The ID of the Managed Resource Group created by the Databricks Workspace.|||
|workspace_url|The workspace URL which is of the format 'adb-{workspaceId}.{random}.azuredatabricks.net'|||
|workspace_id|The unique identifier of the databricks workspace in Databricks control plane.|||
|storage_account_identity|A `storage_account_identity` block as documented below.|||
