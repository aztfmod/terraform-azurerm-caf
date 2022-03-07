module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# synapse_linked_service

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name which should be used for this Synapse Linked Service. Changing this forces a new Synapse Linked Service to be created.||True|
|synapse_workspace|The `synapse_workspace` block as defined below.|Block|True|
|type| The type of data stores that will be connected to Synapse. For full list of supported data stores, please refer to [Azure Synapse connector](https://docs.microsoft.com/en-us/azure/data-factory/connector-overview). Changing this forces a new Synapse Linked Service to be created.||True|
|type_properties_json| A JSON object that contains the properties of the Synapse Linked Service.||True|
|additional_properties| A map of additional properties to associate with the Synapse Linked Service.||False|
|annotations| List of tags that can be used for describing the Synapse Linked Service.||False|
|description| The description for the Synapse Linked Service.||False|
|integration_runtime| A `integration_runtime` block as defined below.| Block |False|
|parameters| A map of parameters to associate with the Synapse Linked Service.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|synapse_workspace| key | Key for  synapse_workspace||| Required if  |
|synapse_workspace| lz_key |Landing Zone Key in wich the synapse_workspace is located|||True|
|synapse_workspace| id | The id of the synapse_workspace |||True|
|integration_runtime|name| The integration runtime reference to associate with the Synapse Linked Service.|||True|
|integration_runtime|parameters| A map of parameters to associate with the integration runtime.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Synapse Linked Service.|||
