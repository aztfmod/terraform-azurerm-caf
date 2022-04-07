# data_factory_linked_service_azure_blob_storage

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
|name| Specifies the name of the Data Factory Linked Service. Changing this forces a new resource to be created. Must be unique within a data factory. See the [Microsoft documentation](https://docs.microsoft.com/en-us/azure/data-factory/naming-rules) for all restrictions.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|data_factory|The `data_factory` block as defined below.|Block|True|
|description| The description for the Data Factory Linked Service.||False|
|integration_runtime_name| The integration runtime reference to associate with the Data Factory Linked Service.||False|
|annotations| List of tags that can be used for describing the Data Factory Linked Service.||False|
|parameters| A map of parameters to associate with the Data Factory Linked Service.||False|
|additional_properties| A map of additional properties to associate with the Data Factory Linked Service.||False|
|connection_string| The connection string. Conflicts with `sas_uri` and `service_endpoint`.||False|
|sas_uri| The SAS URI. Conflicts with `connection_string` and `service_endpoint`.||False|
|key_vault_sas_token| A `key_vault_sas_token` block as defined below. Use this argument to store SAS Token in an existing Key Vault. It needs an existing Key Vault Data Factory Linked Service. A `sas_uri` is required.| Block |False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|data_factory| key | Key for  data_factory||| Required if  |
|data_factory| lz_key |Landing Zone Key in wich the data_factory is located|||True|
|data_factory| name | The name of the data_factory |||True|
|key_vault_sas_token|linked_service_name| Specifies the name of an existing Key Vault Data Factory Linked Service.|||True|
|key_vault_sas_token|secret_name| Specifies the secret name in Azure Key Vault that stores the sas token.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Data Factory Linked Service.|||

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# data_factory_dataset_azure_blob

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
|name| Specifies the name of the Data Factory Dataset. Changing this forces a new resource to be created. Must be globally unique. See the [Microsoft documentation](https://docs.microsoft.com/en-us/azure/data-factory/naming-rules) for all restrictions.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|data_factory|The `data_factory` block as defined below.|Block|True|
|linked_service_name| The Data Factory Linked Service name in which to associate the Dataset with.||True|
|folder| The folder that this Dataset is in. If not specified, the Dataset will appear at the root level.||False|
|schema_column| A `schema_column` block as defined below.| Block |False|
|description| The description for the Data Factory Dataset.||False|
|annotations| List of tags that can be used for describing the Data Factory Dataset.||False|
|parameters| A map of parameters to associate with the Data Factory Dataset.||False|
|additional_properties| A map of additional properties to associate with the Data Factory Dataset.||False|
|path| The path of the Azure Blob.||True|
|filename| The filename of the Azure Blob.||True|
|dynamic_path_enabled| Is the `path` using dynamic expression, function or system variables? Defaults to `false`.||False|
|dynamic_filename_enabled| Is the `filename` using dynamic expression, function or system variables? Defaults to `false`.||False|

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
|id|The ID of the Data Factory Dataset.|||
