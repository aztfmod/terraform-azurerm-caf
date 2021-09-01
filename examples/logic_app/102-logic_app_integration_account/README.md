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
  rglaia1 = {
    name   = "exampleRG1"
    region = "region1"
  }
}

logic_app_integration_account = {
  laia1 = {
    name               = "example-ia"
    region             = "region1"
    resource_group_key = "rglaia1"
    sku_name           = "Standard"
  }
}
```
# logic_app_integration_account

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|


## Outputs
| Name | Description |
|------|-------------|

