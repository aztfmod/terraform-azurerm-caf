# Azure Logic App

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westus"
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

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|


## Outputs
| Name | Description |
|------|-------------|

