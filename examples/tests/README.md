# Terraform Test Commands

This README provides an example on how to use locally Terraform test commands.

## Running Tests

To run tests in Terraform, you can use the following command:

```bash
terraform -chdir=./examples test \
-test-directory=./tests/mock \
-var-file=../examples/communication/communication_services/101-communication_service/configuration.tfvars \
-verbose
```

It will output the following:
```bash
tests/mock/e2e_plan.tftest.hcl... in progress
  run "test_plan"... pass

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.example.random_string.prefix[0] will be created
  + resource "random_string" "prefix" {
      + id          = (known after apply)
      + length      = 4
      + lower       = true
      + min_lower   = 0
      + min_numeric = 0
      + min_special = 0
      + min_upper   = 0
      + number      = false
      + numeric     = false
      + result      = (known after apply)
      + special     = false
      + upper       = false
    }

  # module.example.module.communication_services["cs1"].azurecaf_name.acs will be created
  + resource "azurecaf_name" "acs" {
      + clean_input   = true
      + id            = (known after apply)
      + name          = "test-acs1-re1"
      + passthrough   = false
      + prefixes      = (known after apply)
      + random_length = 0
      + resource_type = "azurerm_communication_service"
      + result        = (known after apply)
      + results       = (known after apply)
      + separator     = "-"
      + use_slug      = true
    }

  # module.example.module.communication_services["cs1"].azurerm_communication_service.acs will be created
  + resource "azurerm_communication_service" "acs" {
      + data_location               = "United States"
      + id                          = (known after apply)
      + name                        = (known after apply)
      + primary_connection_string   = (known after apply)
      + primary_key                 = (known after apply)
      + resource_group_name         = (known after apply)
      + secondary_connection_string = (known after apply)
      + secondary_key               = (known after apply)
      + tags                        = {
          + "module" = "communication_services"
        }
    }

  # module.example.module.communication_services["cs2"].azurecaf_name.acs will be created
  + resource "azurecaf_name" "acs" {
      + clean_input   = true
      + id            = (known after apply)
      + name          = "test-acs2-re2"
      + passthrough   = false
      + prefixes      = (known after apply)
      + random_length = 0
      + resource_type = "azurerm_communication_service"
      + result        = (known after apply)
      + results       = (known after apply)
      + separator     = "-"
      + use_slug      = true
    }

  # module.example.module.communication_services["cs2"].azurerm_communication_service.acs will be created
  + resource "azurerm_communication_service" "acs" {
      + data_location               = "United States"
      + id                          = (known after apply)
      + name                        = (known after apply)
      + primary_connection_string   = (known after apply)
      + primary_key                 = (known after apply)
      + resource_group_name         = (known after apply)
      + secondary_connection_string = (known after apply)
      + secondary_key               = (known after apply)
      + tags                        = {
          + "module" = "communication_services"
        }
    }

  # module.example.module.resource_groups["rg1"].azurecaf_name.rg will be created
  + resource "azurecaf_name" "rg" {
      + clean_input   = true
      + id            = (known after apply)
      + name          = "rg1"
      + passthrough   = false
      + prefixes      = (known after apply)
      + random_length = 0
      + resource_type = "azurerm_resource_group"
      + result        = (known after apply)
      + results       = (known after apply)
      + separator     = "-"
      + use_slug      = true
    }

  # module.example.module.resource_groups["rg1"].azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "australiacentral"
      + name     = (known after apply)
      + tags     = {
          + "landingzone"   = "examples"
          + "rover_version" = null
        }
    }

Plan: 7 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + objects = (sensitive value)

tests/mock/e2e_plan.tftest.hcl... tearing down
tests/mock/e2e_plan.tftest.hcl... pass

Success! 1 passed, 0 failed.

```
