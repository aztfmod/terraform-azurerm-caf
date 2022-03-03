module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# synapse_workspace_aad_admin

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|synapse_workspace|The `synapse_workspace` block as defined below.|Block|True|
|login| The login name of the Azure AD Administrator of this Synapse Workspace.||True|
|object_id| The object id of the Azure AD Administrator of this Synapse Workspace.||True|
|tenant_id| The tenant id of the Azure AD Administrator of this Synapse Workspace.||True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|synapse_workspace| key | Key for  synapse_workspace||| Required if  |
|synapse_workspace| lz_key |Landing Zone Key in wich the synapse_workspace is located|||True|
|synapse_workspace| id | The id of the synapse_workspace |||True|

## Outputs
| Name | Description |
|------|-------------|
