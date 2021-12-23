# Azure Ligthouse

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
  # insert the 7 required variables here
}
```
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# lighthouse_assignment

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| A unique UUID/GUID which identifies this lighthouse assignment- one will be generated if not specified. Changing this forces a new resource to be created.||False|
|scope| The scope at which the Lighthouse Assignment applies too, such as `/subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333` or `/subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333/resourceGroups/myGroup`. Changing this forces a new resource to be created.||True|
|lighthouse_definition|The `lighthouse_definition` block as defined below.|Block|True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|lighthouse_definition| key | Key for  lighthouse_definition||| Required if  |
|lighthouse_definition| lz_key |Landing Zone Key in wich the lighthouse_definition is located|||True|
|lighthouse_definition| id | The id of the lighthouse_definition |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|the fully qualified ID of the Lighthouse Assignment.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# lighthouse_definition

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|lighthouse_definition|The `lighthouse_definition` block as defined below.|Block|False|
|name| The name of the Lighthouse Definition. Changing this forces a new resource to be created.||True|
|managing_tenant_id| The ID of the managing tenant. Changing this forces a new resource to be created.||True|
|scope| The ID of the managed subscription. Changing this forces a new resource to be created.||True|
|authorization| An authorization block as defined below.| Block |True|
|description| A description of the Lighthouse Definition.||False|
|plan| A `plan` block as defined below.| Block |False|
|principal_id| Principal ID of the security group/service principal/user that would be assigned permissions to the projected subscription.||True|
|role_definition|The `role_definition` block as defined below.|Block|True|
|delegated_role_definition_ids| The set of role definition ids which define all the permissions that the principal id can assign.||False|
|principal_display_name| The display name of the security group/service principal/user that would be assigned permissions to the projected subscription.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|lighthouse_definition| key | Key for  lighthouse_definition||| Required if  |
|lighthouse_definition| lz_key |Landing Zone Key in wich the lighthouse_definition is located|||False|
|lighthouse_definition| id | The id of the lighthouse_definition |||False|
|authorization|principal_id| Principal ID of the security group/service principal/user that would be assigned permissions to the projected subscription.|||True|
|authorization|role_definition_id| The role definition identifier. This role will define the permissions that are granted to the principal. This cannot be an `Owner` role.|||True|
|authorization|delegated_role_definition_ids| The set of role definition ids which define all the permissions that the principal id can assign.|||False|
|authorization|principal_display_name| The display name of the security group/service principal/user that would be assigned permissions to the projected subscription.|||False|
|plan|name| The plan name of the marketplace offer.|||True|
|plan|publisher| The publisher ID of the plan.|||True|
|plan|product| The product code of the plan.|||True|
|plan|version| The version of the plan.|||True|
|role_definition| key | Key for  role_definition||| Required if  |
|role_definition| lz_key |Landing Zone Key in wich the role_definition is located|||True|
|role_definition| id | The id of the role_definition |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|the fully qualified ID of the Lighthouse Definition.|||
