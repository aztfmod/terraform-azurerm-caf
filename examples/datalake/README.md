module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# data_lake_store

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Data Lake Store. Changing this forces a new resource to be created. Has to be between 3 to 24 characters.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|tier| The monthly commitment tier for Data Lake Store. Accepted values are `Consumption`, `Commitment_1TB`, `Commitment_10TB`, `Commitment_100TB`, `Commitment_500TB`, `Commitment_1PB` or `Commitment_5PB`.||False|
|encryption_state| Is Encryption enabled on this Data Lake Store Account? Possible values are `Enabled` or `Disabled`. Defaults to `Enabled`.||False|
|encryption_type| The Encryption Type used for this Data Lake Store Account. Currently can be set to `ServiceManaged` when `encryption_state` is `Enabled` - and must be a blank string when it's Disabled.||False|
|identity| An `identity` block defined below.| Block |True|
|firewall_allow_azure_ips|are Azure Service IP's allowed through the firewall? Possible values are `Enabled` and `Disabled`. Defaults to `Enabled.`||False|
|firewall_state|the state of the Firewall. Possible values are `Enabled` and `Disabled`. Defaults to `Enabled.`||False|
|tags| A mapping of tags to assign to the resource.||False|
|type| The Type of Identity which should be used for this Data Lake Store Account. At this time the only possible value is `SystemAssigned`.||True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|identity|type| The Type of Identity which should be used for this Data Lake Store Account. At this time the only possible value is `SystemAssigned`.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Data Lake Store.|||
|endpoint|The Endpoint for the Data Lake Store.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# data_lake_store_file

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|account_name| Specifies the name of the Data Lake Store for which the File should created.||True|
|local_file_path| The path to the local file to be added to the Data Lake Store.||True|
|remote_file_path| The path created for the file on the Data Lake Store.||True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Data Lake Store File.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# data_lake_analytics_account

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Data Lake Analytics Account. Changing this forces a new resource to be created. Has to be between 3 to 24 characters.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|default_store_account_name| Specifies the data lake store to use by default. Changing this forces a new resource to be created.||True|
|tier| The monthly commitment tier for Data Lake Analytics Account. Accepted values are `Consumption`, `Commitment_100000AUHours`, `Commitment_10000AUHours`, `Commitment_1000AUHours`, `Commitment_100AUHours`, `Commitment_500000AUHours`, `Commitment_50000AUHours`, `Commitment_5000AUHours`, or `Commitment_500AUHours`.||False|
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
|id|The ID of the Data Lake Analytics Account.|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# data_lake_store_firewall_rule

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Data Lake Store. Changing this forces a new resource to be created. Has to be between 3 to 24 characters.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|account_name| Specifies the name of the Data Lake Store for which the Firewall Rule should take effect.||True|
|start_ip_address| The Start IP address for the firewall rule.||True|
|end_ip_address| The End IP Address for the firewall rule.||True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Data Lake Store Firewall Rule.|||
