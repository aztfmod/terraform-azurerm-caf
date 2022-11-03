resource "azurecaf_name" "ag1_name" {
  name          = var.settings.action_group_name
  prefixes      = var.global_settings.prefixes
  resource_type = "azurerm_monitor_action_group"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurecaf_name" "service_health_alert_name" {
  name          = var.settings.name
  prefixes      = var.global_settings.prefixes
  resource_type = "azurerm_application_insights"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "random_string" "random1" {
  length  = 16
  special = false

}
resource "azurerm_monitor_action_group" "ag1" {
  name                = azurecaf_name.ag1_name.result
  resource_group_name = var.resource_group_name
  short_name          = var.settings.shortname
  enabled             = var.settings.enable_service_health_alerts


  dynamic "email_receiver" {
    for_each = try(var.settings.email_alert_settings, {})
    content {
      name                    = email_receiver.value.name
      email_address           = email_receiver.value.email_address
      use_common_alert_schema = email_receiver.value.use_common_alert_schema
    }

  }


  dynamic "sms_receiver" {
    for_each = try(var.settings.sms_alert_settings, {})
    content {
      name         = sms_receiver.value.name
      country_code = sms_receiver.value.country_code
      phone_number = sms_receiver.value.phone_number
    }
  }

  dynamic "webhook_receiver" {
    for_each = try(var.settings.webhook, {})
    content {
      name        = webhook_receiver.value.name
      service_uri = webhook_receiver.value.service_uri
    }
  }

  dynamic "arm_role_receiver" {
    for_each = try(var.settings.arm_role_alert, {})
    content {
      name                    = arm_role_receiver.value.name
      role_id                 = regex("[0-9a-f-]{36}.?", data.azurerm_role_definition.arm_role[arm_role_receiver.key].id)
      use_common_alert_schema = arm_role_receiver.value.use_common_alert_schema
    }
  }

}

// Replaced with azapi_resource
/* resource "azurerm_template_deployment" "alert1" {
  name                = random_string.random1.result
  resource_group_name = var.resource_group_name

  template_body = file("${path.module}/alert-servicehealth.json")
  parameters = {
    "name"              = azurecaf_name.service_health_alert_name.result
    "actionGroups_name" = azurerm_monitor_action_group.ag1.name
    "region"            = var.location
  }
  deployment_mode = "Incremental"
}
*/

resource "azapi_resource" "alert1" {
  type = "Microsoft.Insights/activityLogAlerts@2020-10-01"
  name = random_string.random1.result
  location = var.location
  parent_id = var.subscription_id
  tags = var.tags
  body = jsonencode({
    properties = {
      actions = {
        actionGroups = [
          {
            actionGroupId = azurerm_monitor_action_group.ag1.id
            webhookProperties = {}
          }
        ]
      }
      condition = {
        allOf = [
          {
            equals = "ServiceHealth"
            field = "category"
          },
          {
            containsAny = [var.location]
            field = "RegionName"
          }
        ]
      }
      description = ""
      enabled = true
      scopes = [
        var.subscription_id
      ]
    }
  })
}


# blinQ: What is this, point at azurerm_resource_group.example.id, this module need to be updated and tested.

/*
resource "azurerm_monitor_activity_log_alert" "alert1" {
  name = random_string.random1.result
  resource_group_name = var.resource_group_name

  scopes              = [azurerm_resource_group.example.id]
  description         = "This alert will monitor a specific storage account updates."

  criteria {
    resource_id    = azurerm_storage_account.to_monitor.id
    operation_name = "Microsoft.Storage/storageAccounts/write"
    category       = "Recommendation"
  }

  action {
    action_group_id = azurerm_monitor_action_group.ag1.id

    webhook_properties = {
      from = "terraform"
    }
  }

}
*/


data "azurerm_role_definition" "arm_role" {
  for_each = try(var.settings.arm_role_alert, {})
  name     = each.value.role_name
}
