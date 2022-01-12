module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# api_management_user

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|api_management|The `api_management` block as defined below.|Block|True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|email| The email address associated with this user.||True|
|first_name| The first name for this user.||True|
|last_name| The last name for this user.||True|
|user_id| The Identifier for this User, which must be unique within the API Management Service. Changing this forces a new resource to be created.||True|
|confirmation| The kind of confirmation email which will be sent to this user. Possible values are `invite` and `signup`. Changing this forces a new resource to be created.||False|
|note| A note about this user.||False|
|password| The password associated with this user.||False|
|state| The state of this user. Possible values are `active`, `blocked` and `pending`.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|api_management| key | Key for  api_management||| Required if  |
|api_management| lz_key |Landing Zone Key in wich the api_management is located|||True|
|api_management| name | The name of the api_management |||True|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the API Management User.|||
