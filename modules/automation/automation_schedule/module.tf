
resource "azurecaf_name" "automation_schedule" {
  name          = var.settings.name
  resource_type = "azurerm_automation_schedule"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_automation_schedule" "automation_schedule" {
  name                    = azurecaf_name.automation_schedule.result
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  frequency               = var.frequency
  interval                = try(var.settings.interval, null)
  timezone                = try(var.settings.timezone, null)
  start_time              = try(var.settings.start_time, null)
  description             = try(var.settings.description, null)
  week_days               = try(var.settings.week_days, null)
  month_days              = try(var.settings.month_days, null)

  dynamic "monthly_occurrence" {
    for_each = try(var.settings.monthly_occurrences, null) == null ? [] : [1]

    content {
      day        = monthly_occurrence.day
      occurrence = monthly_occurrence.occurrence
    }
  }

  dynamic "timeouts" {
    for_each = lookup(var.settings, "timeouts", {}) == {} ? [] : [1]

    content {
      create = try(var.settings.timeouts.create, "30m")
      read   = try(var.settings.timeouts.read, "30m")
      update = try(var.settings.timeouts.update, "30m")
      delete = try(var.settings.timeouts.delete, "30m")
    }
  }
}