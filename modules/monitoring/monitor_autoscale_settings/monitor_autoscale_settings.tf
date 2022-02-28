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
  enabled             = var.settings.enabled

  dynamic "profile" {
    for_each = var.settings.profiles
    content {
      name = profile.value.name

      capacity {
        default = profile.value.capacity.default
        minimum = profile.value.capacity.minimum
        maximum = profile.value.capacity.maximum
      }

      dynamic "rule" {
        for_each = try(profile.value.rules, {}) == "rules" ? [profile.value.rules] : []
        content {
          metric_trigger {
            metric_name              = rule.value.metric_trigger.metric_name
            metric_resource_id       = try(rule.value.metric_trigger.metric_resource_id, var.target_resource_id)
            time_grain               = rule.value.metric_trigger.time_grain
            statistic                = rule.value.metric_trigger.statistic
            time_window              = rule.value.metric_trigger.time_window
            time_aggregation         = rule.value.metric_trigger.time_aggregation
            operator                 = rule.value.metric_trigger.operator
            threshold                = rule.value.metric_trigger.threshold
            metric_namespace         = try(rule.value.metric_trigger.metric_namespace, null)
            divide_by_instance_count = try(rule.value.metric_trigger.divide_by_instance_count, null)
            dynamic "dimensions" {
              for_each = try(rule.value.metric_trigger.dimensions, {}) == {} ? [] : [1]
              content {
                name     = dimensions.value.name
                operator = dimensions.value.operator
                values   = dimensions.value.values
              }
            }
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
        for_each = try(var.settings.profiles[profile.key].recurrence, {}) == {} ? [] : [1]
        content {
          timezone = var.settings.profiles[profile.key].recurrence.timezone
          days     = var.settings.profiles[profile.key].recurrence.days
          hours    = var.settings.profiles[profile.key].recurrence.hours
          minutes  = var.settings.profiles[profile.key].recurrence.minutes
        }
      }

      dynamic "fixed_date" {
        for_each = try(var.settings.profiles[profile.key].fixed_date, {}) == {} ? [] : [1]
        content {
          timezone = try(var.settings.profiles[profile.key].fixed_date.timezone, null)
          start    = var.settings.profiles[profile.key].fixed_date.start
          end      = var.settings.profiles[profile.key].fixed_date.end
        }
      }

    }
  }

  dynamic "notification" {
    for_each = try(var.settings.notification, {}) == {} ? [] : [1]
    content {

      dynamic "email" {
        for_each = try(var.settings.notification.email, {}) == {} ? [] : [1]
        content {
          send_to_subscription_administrator    = try(var.settings.notification.email.send_to_subscription_administrator, null)
          send_to_subscription_co_administrator = try(var.settings.notification.email.send_to_subscription_co_administrator, null)
          custom_emails                         = try(var.settings.notification.email.custom_emails, null)
        }
      }

      dynamic "webhook" {
        for_each = try(var.settings.profiles.notification.webhook, {}) == {} ? [] : [1]
        content {
          service_uri = var.settings.profiles.notification.webhook.service.uri
          properties  = try(var.settings.profiles.notification.webhook.properties, null)
        }
      }
    }
  }
}
