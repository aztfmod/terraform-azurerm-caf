module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# synapse_firewall_rule

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The Name of the firewall rule. Changing this forces a new resource to be created.||True|
|synapse_workspace|The `synapse_workspace` block as defined below.|Block|True|
|start_ip_address| The starting IP address to allow through the firewall for this rule.||True|
|end_ip_address| The ending IP address to allow through the firewall for this rule.||True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|synapse_workspace| key | Key for  synapse_workspace||| Required if  |
|synapse_workspace| lz_key |Landing Zone Key in wich the synapse_workspace is located|||True|
|synapse_workspace| id | The id of the synapse_workspace |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The Synapse Firewall Rule ID.|||
