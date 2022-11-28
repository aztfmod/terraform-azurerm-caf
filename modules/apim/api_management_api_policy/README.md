module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# api_management_api_policy

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|api_name| The ID of the API Management API within the API Management Service. Changing this forces a new resource to be created.||True|
|api_management|The `api_management` block as defined below.|Block|True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|xml_content| The XML Content for this Policy as a string. An XML file can be used here with Terraform's [file function](https://www.terraform.io/docs/configuration/functions/file.html) that is similar to Microsoft's `PolicyFilePath` option.||False|
|xml_link| A link to a Policy XML Document, which must be publicly available.||False|

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
|id|The ID of the API Management API Policy.|||
