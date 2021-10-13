# Azure Logic App

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
  # insert the 7 required variables here
}
```


## Usage
You can go to the examples folder, however the usage of the module could be like this in your own main.tf file:

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
```
# logic_app_workflow
Estimated execution time
|    Apply    |  Time     |
|------|-------------|
|real    |3m37.529s  |
|user    |3m47.249s |
|sys     |0m18.925s |

| Destroy|  Time     |
|------|-------------|
|real    |2m52.582s  |
|user    |0m40.169s |
|sys     |0m8.247s |

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|


## Outputs
| Name | Description |
|------|-------------|

