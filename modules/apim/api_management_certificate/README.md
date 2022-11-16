module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# api_management_certificate

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the API Management Certificate. Changing this forces a new resource to be created.||True|
|api_management|The `api_management` block as defined below.|Block|True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|data| The base-64 encoded certificate data, which must be a PFX file. Changing this forces a new resource to be created.||False|
|password| The password used for this certificate. Changing this forces a new resource to be created.||False|
|key_vault_secret|The `key_vault_secret` block as defined below.|Block|False|
|key_vault_identity_client_id| The Client ID of the User Assigned Managed Identity to use for retrieving certificate.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|api_management| key | Key for  api_management||| Required if  |
|api_management| lz_key |Landing Zone Key in wich the api_management is located|||True|
|api_management| name | The name of the api_management |||True|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|key_vault_secret| key | Key for  key_vault_secret||| Required if  |
|key_vault_secret| lz_key |Landing Zone Key in wich the key_vault_secret is located|||False|
|key_vault_secret| id | The id of the key_vault_secret |||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the API Management Certificate.|||
|expiration|The Expiration Date of this Certificate, formatted as an RFC3339 string.|||
|subject|The Subject of this Certificate.|||
|thumbprint|The Thumbprint of this Certificate.|||
