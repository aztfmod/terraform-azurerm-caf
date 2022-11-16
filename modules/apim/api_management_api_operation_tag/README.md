module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# api_management_api_operation_tag

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|api_operation_id| The ID of the API Management API Operation. Changing this forces a new API Management API Operation Tag to be created.||True|
|name| The name which should be used for this API Management API Operation Tag. Changing this forces a new API Management API Operation Tag to be created. The name must be unique in the API Management Service.||True|
|display_name| The display name of the API Management API Operation Tag.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the API Management API Operation Tag.|||
