resource "azurecaf_name" "this_name" {
  name          = var.settings.name
  prefixes      = var.global_settings.prefixes
  resource_type = "azurerm_monitor_autoscale_setting"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_monitor_autoscale_setting" "this" {
  name                = azurecaf_name.this_name.result
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = var.target_resource_id

  dynamic "profile" {
    for_each = var.settings
    content {
      name = profile.value.name

      capacity {
        default = profile.value.capacity.default
        minimum = profile.value.capacity.minimum
        maximum = profile.value.capacity.maximum
      }

      dynamic "rule" {
        for_each = var.settings.rules
        content {
          metric_trigger {
            metric_name        = rule.value.metric_trigger.metric_name
            metric_resource_id = try(rule.value.metric_trigger.metric_resource_id, var.target_resource_id)
            time_grain         = rule.value.metric_trigger.time_grain
            statistic          = rule.value.metric_trigger.statistic
            time_window        = rule.value.metric_trigger.time_window
            time_aggregation   = rule.value.metric_trigger.time_aggregation
            operator           = rule.value.metric_trigger.operator
            threshold          = rule.value.metric_trigger.threshold
          }
          scale_action {
            direction = rule.value.scale_action.direction
            type      = rule.value.scale_action.type
            value     = rule.value.scale_action.value
            cooldown  = rule.value.scale_action.cooldown
          }
        }
      }

      dynamic "recurrence" {
        for_each = try(var.settings.recurrence, {})
        content {
          timezone = recurrence.value.timezone
          days     = recurrence.value.days
          hours    = recurrence.value.hours
          minutes  = recurrence.value.minutes
        }
      }

      dynamic "fixed_date" {
        for_each = try(var.settings.fixed_date, {})
        content {
          timezone = try(fixed_date.value.timezone, "")
          start    = fixed_date.value.start
          end      = fixed_date.value.end
        }
      }

    }

    dynamic "notification" {
      for_each = try(var.settings.notification, {})
      content {
        email {
          send_to_subscription_administrator    = notification.value.email.send_to_subscription_administrator
          send_to_subscription_co_administrator = notification.value.email.send_to_subscription_co_administrator
          custom_emails                         = notification.value.email.custom_emails
        }
      }
    }

  }
}
