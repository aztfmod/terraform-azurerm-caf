resource "azurecaf_name" "this_name" {
  name          = var.settings.action_group_name
  prefixes      = var.global_settings.prefixes
  resource_type = "azurerm_monitor_action_group"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_monitor_action_group" "this" {
  name                = azurecaf_name.this_name.result
  resource_group_name = var.resource_group_name
  short_name          = var.settings.shortname
  tags                = try(var.settings.tags, {})

  dynamic "arm_role_receiver" {
    for_each = try(var.settings.arm_role_alert, {})
    content {
      name                    = arm_role_receiver.value.name
      role_id                 = regex("[0-9a-f-]{36}.?", data.azurerm_role_definition.arm_role[arm_role_receiver.key].id)
      use_common_alert_schema = try(arm_role_receiver.value.use_common_alert_schema, false)
    }
  }

  dynamic "automation_runbook_receiver" {
    for_each = try(var.settings.automation_runbook_receiver, {})
    content {
      name                    = automation_runbook_receiver.value.name
      automation_account_id   = automation_runbook_receiver.value.automation_account_id
      runbook_name            = automation_runbook_receiver.value.runbook_name
      webhook_resource_id     = automation_runbook_receiver.value.webhook_resource_id
      is_global_runbook       = automation_runbook_receiver.value.is_global_runbook
      service_uri             = automation_runbook_receiver.value.service_uri
      use_common_alert_schema = try(automation_runbook_receiver.value.use_common_alert_schema, false)
    }
  }

  dynamic "azure_app_push_receiver" {
    for_each = try(var.settings.azure_app_push_receiver, {})
    content {
      name          = azure_app_push_receiver.value.name
      email_address = azure_app_push_receiver.value.email_address
    }
  }

  dynamic "azure_function_receiver" {
    for_each = try(var.settings.azure_function_receiver, {})
    content {
      name                     = azure_function_receiver.value.name
      function_app_resource_id = azure_function_receiver.value.function_app_resource_id
      function_name            = azure_function_receiver.value.function_name
      http_trigger_url         = azure_function_receiver.value.http_trigger_url
      use_common_alert_schema  = try(azure_function_receiver.value.use_common_alert_schema, false)
    }
  }

  dynamic "email_receiver" {
    for_each = try(var.settings.email_receiver, {})
    content {
      name                    = email_receiver.value.name
      email_address           = email_receiver.value.email_address
      use_common_alert_schema = try(email_receiver.value.use_common_alert_schema, false)
    }
  }
  dynamic "event_hub_receiver" {
    for_each = try(var.settings.event_hub_receiver, {})
    content {
      name = event_hub_receiver.value.name
      event_hub_id = coalesce(
        try(var.remote_objects.event_hub_namespaces[event_hub_receiver.value.event_hub.lz_key][event_hub_receiver.value.event_hub.key].id, null),
        try(var.remote_objects.event_hub_namespaces[var.client_config.landingzone_key][event_hub_receiver.value.event_hub.key].id, null),
        try(event_hub_receiver.value.event_hub.key, null)
      )
      tenant_id               = try(event_hub_receiver.value.tenant_id, null)
      use_common_alert_schema = try(event_hub_receiver.value.use_common_alert_schema, null)
    }
  }
  dynamic "itsm_receiver" {
    for_each = try(var.settings.itsm_receiver, {})
    content {
      name                 = itsm_receiver.value.name
      workspace_id         = itsm_receiver.value.workspace_id
      connection_id        = itsm_receiver.value.connection_id
      ticket_configuration = itsm_receiver.value.ticket_configuration
      region               = itsm_receiver.value.region
    }
  }

  dynamic "logic_app_receiver" {
    for_each = try(var.settings.logic_app_receiver, {})
    content {
      name                    = logic_app_receiver.value.name
      resource_id             = logic_app_receiver.value.resource_id
      callback_url            = logic_app_receiver.value.callback_url
      use_common_alert_schema = try(logic_app_receiver.value.use_common_alert_schema, false)
    }
  }

  dynamic "sms_receiver" {
    for_each = try(var.settings.sms_receiver, {})
    content {
      name         = sms_receiver.value.name
      country_code = sms_receiver.value.country_code
      phone_number = sms_receiver.value.phone_number
    }
  }

  dynamic "voice_receiver" {
    for_each = try(var.settings.voice_receiver, {})
    content {
      name         = voice_receiver.value.name
      country_code = voice_receiver.value.country_code
      phone_number = voice_receiver.value.phone_number
    }
  }

  dynamic "webhook_receiver" {
    for_each = try(var.settings.webhook_receiver, {})
    content {
      name                    = webhook_receiver.value.name
      service_uri             = webhook_receiver.value.service_uri
      use_common_alert_schema = try(webhook_receiver.value.use_common_alert_schema, false)

      dynamic "aad_auth" {
        for_each = try(var.settings.webhook_receiver.aad_auth, null) == null ? [] : [1]

        content {
          object_id      = var.settings.webhook_receiver.aad_auth.object_id
          identifier_uri = try(var.settings.webhook_receiver.aad_auth.identifier_uri, null)
          tenant_id      = try(var.settings.webhook_receiver.aad_auth.tenant_id, null)
        }
      }
    }
  }
}

data "azurerm_role_definition" "arm_role" {
  for_each = try(var.settings.arm_role_alert, {})
  name     = each.value.role_name
}