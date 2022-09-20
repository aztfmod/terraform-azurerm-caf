resource "azurerm_dev_test_global_vm_shutdown_schedule" "enabled" {
  count = can(var.settings.shutdown_schedule) ? 1 : 0

  virtual_machine_id = azurerm_linux_virtual_machine.vm[local.os_type].id
  location           = var.location
  enabled            = try(var.settings.shutdown_schedule.enabled, null)

  daily_recurrence_time = var.settings.shutdown_schedule.daily_recurrence_time
  timezone              = var.settings.shutdown_schedule.timezone

  notification_settings {
    enabled         = try(var.settings.shutdown_schedule.notification_settings.enabled, null)
    time_in_minutes = try(var.settings.shutdown_schedule.notification_settings.time_in_minutes, null)
    email           = try(var.settings.shutdown_schedule.notification_settings.email, null)
    webhook_url     = try(var.settings.shutdown_schedule.notification_settings.enabled, false) ? var.settings.shutdown_schedule.notification_settings.webhook_url : try(var.settings.shutdown_schedule.notification_settings.webhook_url, null)
  }
}
