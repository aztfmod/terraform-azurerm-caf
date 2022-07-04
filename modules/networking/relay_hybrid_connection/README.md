module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# relay_hybrid_connection

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Azure Relay Hybrid Connection. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|relay_namespace_name| The name of the Azure Relay in which to create the Azure Relay Hybrid Connection. Changing this forces a new resource to be created.||True|
|requires_client_authorization| Specify if client authorization is needed for this hybrid connection. True by default. Changing this forces a new resource to be created.||False|
|user_metadata| The usermetadata is a placeholder to store user-defined string data for the hybrid connection endpoint. For example, it can be used to store descriptive data, such as a list of teams and their contact information. Also, user-defined configuration settings can be stored.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Relay Hybrid Connection.|||
