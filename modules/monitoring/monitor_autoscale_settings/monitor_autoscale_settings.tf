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

  profile {
    name = var.settings.name

    capacity {
      default = var.settings.capacity.default
      minimum = var.settings.capacity.minimum
      maximum = var.settings.capacity.maximum
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

    recurrence {
      timezone = var.settings.recurrence.timezone
      days     = var.settings.recurrence.days
      hours    = var.settings.recurrence.hours
      minutes  = var.settings.recurrence.minutes
    }

    fixed_date {
      timezone = var.settings.fixed_date.timezone
      start    = var.settings.fixed_date.start
      end      = var.settings.fixed_date.end
    }

  }

  notification {
    email {
      send_to_subscription_administrator    = var.settings.notification.email.send_to_subscription_administrator
      send_to_subscription_co_administrator = var.settings.notification.email.send_to_subscription_co_administrator
      custom_emails                         = var.settings.notification.email.custom_emails
    }
  }
}
