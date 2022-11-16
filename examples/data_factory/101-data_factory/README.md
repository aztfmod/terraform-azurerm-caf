# data_factory

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~>5.5.0"

  # Add object as described below
}
```

CAF Terraform module is iterative by default, you can instantiate as many objects as needed, using the following structure:

```hcl
resource_to_be_created = {
  object1 = {
    #configuration details as below
  }
  object2 = {
    #configuration details as below
  }
}
```


## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name |Specifies the name of the Data Factory. Changing this forces a new resource to be created. Must be globally unique. See the Microsoft documentation for all restrictions.| string ||yes|
|resource_group |Block see below.| block ||yes|
|region |Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.|  string  ||yes|
|github_configuration |A github_configuration block as defined below.| block ||no|
|global_parameter | A list of global_parameter blocks as defined above.| block ||no|
|identity | An identity block as defined below.|||no|
|vsts_configuration | A vsts_configuration block as defined below.| block ||no|
|managed_virtual_network_enabled | Is Managed Virtual Network enabled?| string ||no|
|public_network_enabled | Is the Data Factory visible to the public network? Defaults to true.| boolean | true |no|
|customer_managed_key_id | Specifies the Azure Key Vault Key ID to be used as the Customer Managed Key (CMK) for double encryption. Required with user assigned identity.| string ||no|
|tags | A mapping of tags to assign to the resource.| array ||no|

## Blocks
| Block | Field | Description | Type | Default | Required |
|-------|-------|-------------|------|---------|:--------:|
| resource_group | key | Resource Group Key. | string | |Required when 'name' not defined|
| resource_group | lz_key | Landing Zone Key for a resource group in a different Landing Zone. | string || no |
| resource_group | name | Resource Group name, to be used when a resource group was created externally. | string | | Required when 'key' is not defined. |
|github_configuration|account_name | Specifies the GitHub account name. | string | | yes |
|github_configuration|branch_name |Specifies the branch of the repository to get code from. | string | | yes |
|github_configuration|git_url | Specifies the GitHub Enterprise host name. For example: https://github.mydomain.com. Use https://github.com for open source repositories. | string | | yes |
|github_configuration|repository_name |Specifies the name of the git repository. | string | | yes |
|github_configuration|root_folder | Specifies the root folder within the repository. Set to / for the top level. | string |  | yes |
|global_parameter|name |  Specifies the global parameter name.| string | | yes |
|global_parameter|type |  Specifies the global parameter type. Possible Values are Array, Bool, Float, Int, Object or String. | string | | yes |
|global_parameter| value | Specifies the global parameter value. | string | | yes |
|identity|type |  Specifies the identity type of the Data Factory. Possible values are SystemAssigned, UserAssigned and SystemAssigned,UserAssigned. | string | | yes|
|identity| identity_ids | Specifies the IDs of user assigned identities. Required if UserAssigned or SystemAssigned,UserAssigned type is used. Conflicts with 'managed_identity_keys'| string | | no |
|identity| managed_identity_keys | Specifies the Keys of user assigned identities. Required if UserAssigned or SystemAssigned,UserAssigned type is used. Conflicts with 'identity_ids'| string | | no |
|vsts_configuration|account_name | Specifies the VSTS account name. | string | | yes |
|vsts_configuration| branch_name | Specifies the branch of the repository to get code from. | string | | yes |
|vsts_configuration|project_name | Specifies the name of the VSTS project. | string | | yes |
|vsts_configuration|repository_name | Specifies the name of the git repository. | string | | yes |
|vsts_configuration|root_folder | Specifies the root folder within the repository. Set to / for the top level.| string | | yes |
|vsts_configuration|tenant_id | Specifies the Tenant ID associated with the VSTS account. | string | | yes |

## Outputs
| Name | Description |
|------|-------------|
|id | The ID of the Data Factory.|
|identity | An identity block as defined below.|

## Blocks
| Name | Description |
|------|-------------|
|principal_id | The ID of the Principal (Client) in Azure Active Directory|
|tenant_id | The ID of the Azure Active Directory Tenant.|