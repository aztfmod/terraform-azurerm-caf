resource "azurerm_consumption_budget_resource_group" "this" {
  name              = var.settings.name
  resource_group_id = var.resource_group_id

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
      contact_roles  = try(notification.value.contact_roles, [])
      enabled        = try(notification.value.enabled, true)
    }
  }

  dynamic "filter" {
    for_each = try(var.settings.filter, null) == null ? [] : [1]

    content {
      dynamic "dimension" {
        for_each = var.settings.filter.dimensions

        content {
          name   = dimension.value.name
          values = dimension.value.values
        }
      }
    }
  }
}
