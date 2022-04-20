# Azure Logic App

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiacentral"
  }
}

resource_groups = {
  rgwflow1 = {
    name   = "exampleRG1"
    region = "region1"
  }
}

logic_app_workflow = {
  applogic1 = {
    name               = "workflow1"
    region             = "region1"
    resource_group_key = "rgwflow1"
    #integration_service_environment_key
    #logic_app_integration_account_key
    #workflow_parameters
    #workflow_schema
    workflow_version = "1.0.0.0"
    #parameters
  }
}

logic_app_trigger_http_request = {
  trigger_http_request1 = {
    name         = "webhook"
    logic_app_key = "applogic1"
    schema = <<SCHEMA
{
    "type": "object",
    "properties": {
        "hello": {
            "type": "string"
        }
    }
}
SCHEMA
  }
}
```
# logic_app_trigger_http_request
Estimated execution time
|Apply |    Time |
|------|---------|
|real  |4m53.999s|
|user  |3m52.805s|
|sys   |0m20.137s|

| Destroy|  Time   |
|--------|---------|
|real    |2m42.343s|
|user    |0m38.997s|
|sys     |0m10.361s|


## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|


## Outputs
| Name | Description |
|------|-------------|

