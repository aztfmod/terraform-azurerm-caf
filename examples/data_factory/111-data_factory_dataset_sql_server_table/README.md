# data_factory_linked_service_sql_server

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~>5.5.0"

  # Add object as described below
}
```

CAF Terraform module is iterative by default, you can instantiate as many objects as needed, using the following structure:

```hcl
resource_to_be_created = {
  object1 = {
    #configuration details as below
  }
  object2 = {
    #configuration details as below
  }
}
```


## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Data Factory Linked Service SQL Server. Changing this forces a new resource to be created. Must be unique within a data||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|data_factory|The `data_factory` block as defined below.|Block|True|
|connection_string| The connection string in which to authenticate with the SQL Server. Exactly one of either `connection_string` or `key_vault_connection_string` is required.| Block |False|
|description| The description for the Data Factory Linked Service SQL Server.||False|
|integration_runtime_name| The integration runtime reference to associate with the Data Factory Linked Service SQL Server.||False|
|annotations| List of tags that can be used for describing the Data Factory Linked Service SQL Server.||False|
|parameters| A map of parameters to associate with the Data Factory Linked Service SQL Server.||False|
|additional_properties| A map of additional properties to associate with the Data Factory Linked Service SQL Server.||False|
|key_vault_connection_string| A `key_vault_connection_string` block as defined below. Use this argument to store SQL Server connection string in an existing Key Vault. It needs an existing Key Vault Data Factory Linked Service. Exactly one of either `connection_string` or `key_vault_connection_string` is required.| Block |False|
|key_vault_password| A `key_vault_password` block as defined below. Use this argument to store SQL Server password in an existing Key Vault. It needs an existing Key Vault Data Factory Linked Service.| Block |False|

## Blocks
| BLock | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|data_factory| key | Key for  data_factory||| Required if  |
|data_factory| lz_key |Landing Zone Key in wich the data_factory is located|||True|
|data_factory| name | The name of the data_factory |||True|
|connection_string|linked_service_name| Specifies the name of an existing Key Vault Data Factory Linked Service.|||True|
|connection_string|secret_name| Specifies the secret name in Azure Key Vault that stores SQL Server connection string.|||True|
|key_vault_connection_string|linked_service_name| Specifies the name of an existing Key Vault Data Factory Linked Service.|||True|
|key_vault_connection_string|secret_name| Specifies the secret name in Azure Key Vault that stores SQL Server connection string.|||True|
|key_vault_password|linked_service_name| Specifies the name of an existing Key Vault Data Factory Linked Service.|||True|
|key_vault_password|secret_name| Specifies the secret name in Azure Key Vault that stores SQL Server password.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Data Factory SQL Server Linked Service.|||


# data_factory_dataset_sql_server_table

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~>5.5.0"

  # Add object as described below
}
```

CAF Terraform module is iterative by default, you can instantiate as many objects as needed, using the following structure:

```hcl
resource_to_be_created = {
  object1 = {
    #configuration details as below
  }
  object2 = {
    #configuration details as below
  }
}
```


## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Data Factory Dataset SQL Server Table. Changing this forces a new resource to be created. Must be globally unique. See the [Microsoft documentation](https://docs.microsoft.com/en-us/azure/data-factory/naming-rules) for all restrictions.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|data_factory|The `data_factory` block as defined below.|Block|True|
|linked_service_name| The Data Factory Linked Service name in which to associate the Dataset with.||True|
|table_name| The table name of the Data Factory Dataset SQL Server Table.||False|
|folder| The folder that this Dataset is in. If not specified, the Dataset will appear at the root level.||False|
|schema_column| A `schema_column` block as defined below.| Block |False|
|description| The description for the Data Factory Dataset SQL Server Table.||False|
|annotations| List of tags that can be used for describing the Data Factory Dataset SQL Server Table.||False|
|parameters| A map of parameters to associate with the Data Factory Dataset SQL Server Table.||False|
|additional_properties| A map of additional properties to associate with the Data Factory Dataset SQL Server Table.||False|

## Blocks
| BLock | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|data_factory| key | Key for  data_factory||| Required if  |
|data_factory| lz_key |Landing Zone Key in wich the data_factory is located|||True|
|data_factory| name | The name of the data_factory |||True|
|schema_column|name| The name of the column.|||True|
|schema_column|type| Type of the column. Valid values are `Byte`, `Byte[]`, `Boolean`, `Date`, `DateTime`,`DateTimeOffset`, `Decimal`, `Double`, `Guid`, `Int16`, `Int32`, `Int64`, `Single`, `String`, `TimeSpan`. Please note these values are case sensitive.|||False|
|schema_column|description| The description of the column.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Data Factory SQL Server Table Dataset.|||
