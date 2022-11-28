resource "azurecaf_name" "this_name" {
  name          = var.settings.name
  prefixes      = var.global_settings.prefixes
  resource_type = "azurerm_consumption_budget_resource_group"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_consumption_budget_resource_group" "this" {
  name = azurecaf_name.this_name.result
  resource_group_id = coalesce(
    try(var.settings.resource_group.id, null),
    try(var.local_combined_resources["resource_groups"][try(var.settings.resource_group.lz_key, var.client_config.landingzone_key)][var.settings.resource_group.key].id, null)
  )

  amount     = var.settings.amount
  time_grain = var.settings.time_grain

  time_period {
    start_date = try(var.settings.time_period.start_date, join("", [formatdate("YYYY-MM", timestamp()), "-01T00:00:00Z"]))
    end_date   = try(var.settings.time_period.end_date, null)
  }

  dynamic "notification" {
    for_each = var.settings.notifications

    content {
      operator  = notification.value.operator
      threshold = notification.value.threshold

      contact_emails = try(notification.value.contact_emails, [])
      contact_groups = try(notification.value.contact_groups, try(flatten([
        for key, value in var.local_combined_resources["monitor_action_groups"][try(notification.value.lz_key, var.client_config.landingzone_key)] : value.id
        if contains(notification.value.contact_groups_keys, key)
        ]), [])
      )
      contact_roles = try(notification.value.contact_roles, [])
      enabled       = try(notification.value.enabled, true)
    }
  }

  dynamic "filter" {
    for_each = try(var.settings.filter, null) == null ? [] : [1]

    content {
      dynamic "dimension" {
        for_each = {
          for key, value in try(var.settings.filter.dimensions, {}) : key => value
          if lower(value.name) != "resource_key"
        }

        content {
          name     = dimension.value.name
          operator = try(dimension.value.operator, "In")
          values   = dimension.value.values
        }
      }

      dynamic "dimension" {
        for_each = {
          for key, value in try(var.settings.filter.dimensions, {}) : key => value
          if lower(value.name) == "resource_key"
        }

        content {
          name     = "ResourceId"
          operator = try(dimension.value.operator, "In")
          values = try(flatten([
            for key, value in var.local_combined_resources[dimension.value.resource_key][try(dimension.value.lz_key, var.client_config.landingzone_key)] : value.id
            if contains(dimension.value.values, key)
          ]), [])
        }
      }

      dynamic "tag" {
        for_each = {
          for key, value in try(var.settings.filter.tags, {}) : key => value
        }

        content {
          name     = tag.value.name
          operator = try(tag.value.operator, "In")
          values   = tag.value.values
        }
      }

      dynamic "not" {
        for_each = try(var.settings.filter.not, null) == null ? [] : [1]

        content {
          dynamic "dimension" {
            for_each = {
              for key, value in try(var.settings.filter.not.dimension, {}) : key => value
              if lower(value.name) != "resource_key"
            }

            content {
              name     = dimension.value.name
              operator = try(dimension.value.operator, "In")
              values   = dimension.value.values
            }
          }

          dynamic "dimension" {
            for_each = {
              for key, value in try(var.settings.filter.not.dimension, {}) : key => value
              if lower(value.name) == "resource_key"
            }

            content {
              name     = "ResourceId"
              operator = try(dimension.value.operator, "In")
              values = try(flatten([
                for key, value in var.local_combined_resources[dimension.value.resource_key][try(dimension.value.lz_key, var.client_config.landingzone_key)] : value.id
                if contains(dimension.value.values, key)
              ]), [])
            }
          }

          dynamic "tag" {
            for_each = try(var.settings.filter.not.tag, null) == null ? [] : [1]

            content {
              name     = var.settings.filter.not.tag.name
              operator = try(var.settings.filter.not.tag.operator, "In")
              values   = var.settings.filter.not.tag.values
            }
          }
        }
      }
    }
  }
}
