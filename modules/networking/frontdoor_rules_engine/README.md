module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# frontdoor_rules_engine

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the Rules engine configuration. Changing this forces a new resource to be created.||True|
|frontdoor|The `frontdoor` block as defined below.|Block|True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|rule| A `rule` block as defined below.| Block |True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|frontdoor| key | Key for  frontdoor||| Required if  |
|frontdoor| lz_key |Landing Zone Key in wich the frontdoor is located|||True|
|frontdoor| name | The name of the frontdoor |||True|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|rule|name| The name of the rule.|||True|
|rule|priority| Priority of the rule, must be unique per rules engine definition.|||True|
|rule|action| A `rule_action` block as defined below.|||True|
|rule|match_condition|One or more `match_condition` block as defined below.|||False|

## Outputs
| Name | Description |
|------|-------------|
