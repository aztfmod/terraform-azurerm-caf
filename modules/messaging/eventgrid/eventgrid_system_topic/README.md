module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# eventgrid_system_topic

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the EventGrid System Topic resource. Changing this forces a new resource to be created.||True|
|source_arm_resource_id| Specifies the Resource ID of the source for the Event Grid System Topic. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|location|The location of the EventGrid System Topic. Must be Global||True|
|topic_type|The topic type for the EventGrid System Topic. ||True|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the EventGrid System Topic.|||
|name|The Name of the EventGrid System Topic.|||
