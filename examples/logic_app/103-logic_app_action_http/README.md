# Azure Logic App

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



## Usage
You can go to the examples folder, however the usage of the module could be like this in your own main.tf file:

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

logic_app_action_http = {
  action_http1 = {
    name         = "webhook"
    logic_app_key = "applogic1"
    method       = "GET"
    uri          = "http://example.com/some-webhook"
  }
}
```
# logic_app_action_http
Estimated execution time
|    Apply    |  Time     |
|------|-------------|
|real    |3m20.111s|
|user    |3m47.032s|
|sys     |0m20.601s|

| Destroy|  Time     |
|------|-------------|
|real    |3m1.011s|
|user    |0m38.128s|
|sys     |0m9.920s|


## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
`

## Outputs
| Name | Description |
|------|-------------|

