module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# synapse_managed_private_endpoint

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name which should be used for this Managed Private Endpoint. Changing this forces a new resource to be created.||True|
|synapse_workspace|The `synapse_workspace` block as defined below.|Block|True|
|target_resource_id| The ID of the Private Link Enabled Remote Resource which this Synapse Private Endpoint should be connected to. Changing this forces a new resource to be created.||True|
|subresource_name| Specifies the sub resource name which the Synapse Private Endpoint is able to connect to. Changing this forces a new resource to be created.||True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|synapse_workspace| key | Key for  synapse_workspace||| Required if  |
|synapse_workspace| lz_key |Landing Zone Key in wich the synapse_workspace is located|||True|
|synapse_workspace| id | The id of the synapse_workspace |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The Synapse Managed Private Endpoint ID.|||
