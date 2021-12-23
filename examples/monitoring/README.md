# Deploys Service Health Alerts

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
  # insert the 7 required variables here
}
```

This module tracks the following types of health events (subscription wide) and send alerts:

1. Service issues - Problems in the Azure services that affect you right now.

2. Planned maintenance - Upcoming maintenance that can affect the availability of your services in the future.

3. Health advisories - Changes in Azure services that require your attention.

4. Security advisories - Security related notifications or violations that may affect the availability of your Azure services.

Ref : https://docs.microsoft.com/en-us/azure/service-health/service-health-overview

An Action Group will be created and your choice of Notifications type can be chosen dynamically (refer input syntax).

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurecaf | n/a |
| azurerm | n/a |

##  Input Syntax
```hcl
  # refer example configuration file
   monitoring = {
    service_health_alerts = {
        enable_service_health_alerts = true/false
        name = "<string>"
        action_group_name = "<string>"
        shortname = "<string>"
        resource_group_key = "<string>"

        email_alert_settings = {
          email_alert1 = {
            name = "<string>"
            email_address = "<emailAddress>"
            use_common_alert_schema = true/false
          }
          #remove the following block if additional email alerts aren't needed.
          email_alert2 = {
            name = "<string>"
            email_address = "<emailAddress>"
            use_common_alert_schema = true/false
          }
          ##add more email alerts by repeating the block.
        }

        #comment out this block exclude this configuration completely
        sms_alert_settings = {
          sms_alert1 = {
             name = "<string>"
             country_code ="<countryCode>"
             phone_number = "<phoneNumber>"
           } #follow the syntax of email alert settings to have one or more alerts
        }

        #comment out this block exclude this configuration completely
        #webhook = {
        #  webhook1 = {
          #   name = "<string>"
          #   service_uri = "<URI>"
          # } #follow the syntax of email alert settings to have one or more alerts
        #}

        #comment out this block exclude this configuration completely
        arm_role_alert = {
          arm_alert1 = {
            name = "<string>"
            use_common_alert_schema = true/false
            role_name = "Contributor" # Use the Built-in role names
          } #follow the syntax of email alert settings to have one or more alerts
        }

  }

}

}
```
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# monitor_action_group

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the Action Group. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|short_name| The short name of the action group. This will be used in SMS messages.||True|
|enabled| Whether this action group is enabled. If an action group is not enabled, then none of its receivers will receive communications. Defaults to `true`.||False|
|arm_role_receiver| One or more `arm_role_receiver` blocks as defined below.||False|
|automation_runbook_receiver| One or more `automation_runbook_receiver` blocks as defined below.||False|
|azure_app_push_receiver| One or more `azure_app_push_receiver` blocks as defined below.||False|
|azure_function_receiver| One or more `azure_function_receiver` blocks as defined below.||False|
|email_receiver| One or more `email_receiver` blocks as defined below.||False|
|itsm_receiver| One or more `itsm_receiver` blocks as defined below.||False|
|logic_app_receiver| One or more `logic_app_receiver` blocks as defined below.||False|
|sms_receiver| One or more `sms_receiver` blocks as defined below.||False|
|voice_receiver| One or more `voice_receiver` blocks as defined below.||False|
|webhook_receiver| One or more `webhook_receiver` blocks as defined below.||False|
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
|id|The ID of the Action Group.|||


