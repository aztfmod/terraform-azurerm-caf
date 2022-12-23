module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# eventgrid_domain_topic

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the EventGrid Domain Topic resource. Changing this forces a new resource to be created.||True|
|domain_name| Specifies the name of the EventGrid Domain. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the EventGrid Domain Topic.|||
