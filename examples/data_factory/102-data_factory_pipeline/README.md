# data_factory_pipeline

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
|name| Specifies the name of the Data Factory Pipeline. Changing this forces a new resource to be created. Must be globally unique. See the [Microsoft documentation](https://docs.microsoft.com/en-us/azure/data-factory/naming-rules) for all restrictions.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|data_factory|The `data_factory` block as defined below.|Block|True|
|description| The description for the Data Factory Pipeline.||False|
|annotations| List of tags that can be used for describing the Data Factory Pipeline.||False|
|concurrency| The max number of concurrent runs for the Data Factory Pipeline. Must be between `1` and `50`.||False|
|folder| The folder that this Pipeline is in. If not specified, the Pipeline will appear at the root level.||False|
|moniter_metrics_after_duration| The TimeSpan value after which an Azure Monitoring Metric is fired.||False|
|parameters| A map of parameters to associate with the Data Factory Pipeline.||False|
|variables| A map of variables to associate with the Data Factory Pipeline.||False|
|activities_json| A JSON object that contains the activities that will be associated with the Data Factory Pipeline.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|data_factory| key | Key for  data_factory||| Required if  |
|data_factory| lz_key |Landing Zone Key in wich the data_factory is located|||True|
|data_factory| name | The name of the data_factory |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Data Factory Pipeline.|||
