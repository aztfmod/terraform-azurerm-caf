module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# synapse_workspace

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name which should be used for this synapse Workspace. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|storage_data_lake_gen2_filesystem|The `storage_data_lake_gen2_filesystem` block as defined below.|Block|True|
|sql_administrator_login| Specifies The Login Name of the SQL administrator. Changing this forces a new resource to be created.||True|
|sql_administrator_login_password| The Password associated with the `sql_administrator_login` for the SQL administrator.||True|
|linking_allowed_for_aad_tenant_ids| Allowed Aad Tenant Ids For Linking. ||False|
|compute_subnet_id| Subnet ID used for computes in workspace||False|
|data_exfiltration_protection_enabled| Is data exfiltration protection enabled in this workspace? If set to `true`, `managed_virtual_network_enabled` must also be set to `true`. Changing this forces a new resource to be created.||False|
|managed_virtual_network_enabled| Is Virtual Network enabled for all computes in this workspace? Defaults to `false`. Changing this forces a new resource to be created.||False|
|public_network_access_enabled| Whether public network access is allowed for the Cognitive Account. Defaults to `true`.||False|
|purview_id| The ID of purview account.||False|
|sql_identity_control_enabled| Are pipelines (running as workspace's system assigned identity) allowed to access SQL pools?||False|
|managed_resource_group_name| Workspace managed resource group.||False|
|aad_admin| An `aad_admin` block as defined below. Conflicts with `customer_managed_key`.| Block |False|
|azure_devops_repo| An `azure_devops_repo` block as defined below.| Block |False|
|github_repo| A `github_repo` block as defined below.| Block |False|
|customer_managed_key| A `customer_managed_key` block as defined below. Conflicts with `aad_admin`.| Block |False|
|sql_aad_admin| An `sql_aad_admin` block as defined below.| Block |False|
|tags| A mapping of tags which should be assigned to the Synapse Workspace.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|storage_data_lake_gen2_filesystem| key | Key for  storage_data_lake_gen2_filesystem||| Required if  |
|storage_data_lake_gen2_filesystem| lz_key |Landing Zone Key in wich the storage_data_lake_gen2_filesystem is located|||True|
|storage_data_lake_gen2_filesystem| id | The id of the storage_data_lake_gen2_filesystem |||True|
|aad_admin|login| The login name of the Azure AD Administrator of this Synapse Workspace.|||True|
|aad_admin|object_id| The object id of the Azure AD Administrator of this Synapse Workspace.|||True|
|aad_admin|tenant_id| The tenant id of the Azure AD Administrator of this Synapse Workspace.|||True|
|azure_devops_repo|account_name| Specifies the Azure DevOps account name.|||True|
|azure_devops_repo|branch_name| Specifies the collaboration branch of the repository to get code from.|||True|
|azure_devops_repo|last_commit_id| The last commit ID.|||False|
|azure_devops_repo|project_name| Specifies the name of the Azure DevOps project.|||True|
|azure_devops_repo|repository_name| Specifies the name of the git repository.|||True|
|azure_devops_repo|root_folder| Specifies the root folder within the repository. Set to `/` for the top level.|||True|
|azure_devops_repo|tenant_id| the ID of the tenant for the Azure DevOps account.|||False|
|github_repo|account_name| Specifies the GitHub account name.|||True|
|github_repo|branch_name| Specifies the collaboration branch of the repository to get code from.|||True|
|github_repo|last_commit_id| The last commit ID.|||False|
|github_repo|repository_name| Specifies the name of the git repository.|||True|
|github_repo|root_folder| Specifies the root folder within the repository. Set to `/` for the top level.|||True|
|github_repo|git_url| Specifies the GitHub Enterprise host name. For example: https://github.mydomain.com.|||False|
|customer_managed_key|key_versionless_id| The Azure Key Vault Key Versionless ID to be used as the Customer Managed Key (CMK) for double encryption (e.g. `https://example-keyvault.vault.azure.net/type/cmk/`).|||True|
|customer_managed_key|key_name| An identifier for the key. Name needs to match the name of the key used with the `azurerm_synapse_workspace_key` resource. Defaults to "cmk" if not specified.|||False|
|sql_aad_admin|login| The login name of the Azure AD Administrator of this Synapse Workspace SQL.|||True|
|sql_aad_admin|object_id| The object id of the Azure AD Administrator of this Synapse Workspace SQL.|||True|
|sql_aad_admin|tenant_id| The tenant id of the Azure AD Administrator of this Synapse Workspace SQL.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the synapse Workspace.|||
|connectivity_endpoints|A list of Connectivity endpoints for this Synapse Workspace.|||
|identity|An `identity` block as defined below, which contains the Managed Service Identity information for this Synapse Workspace.|||
