resource "azurerm_virtual_machine_scale_set_extension" "HealthExtension" {
  for_each                     = var.extension_name == "microsoft_azure_health_extension" ? toset(["enabled"]) : toset([])
  name                         = "HealthExtension"
  publisher                    = "Microsoft.ManagedServices"
  type                         = local.application_health_extension_type
  virtual_machine_scale_set_id = var.virtual_machine_scale_set_id
  type_handler_version         = try(var.extension.type_handler_version, "1.0")
  auto_upgrade_minor_version   = try(var.extension.auto_upgrade_minor_version, true)

  lifecycle {
    ignore_changes = [
      settings,
      protected_settings
    ]
  }

  settings = jsonencode({
    "protocol" : try(var.extension.settings.protocol, "http")
    "port" : try(var.extension.settings.port, 80)
    "requestPath" : try(var.extension.settings.requestPath, "/")
    "intervalInSeconds" : try(var.extension.settings.intervalInSeconds, 5.0)
    "numberOfProbes" : try(var.extension.settings.numberOfProbes, 1.0)
    }
  )
}

locals {
  application_health_extension_type = var.virtual_machine_scale_set_os_type == "linux" ? "ApplicationHealthLinux" : "ApplicationHealthWindows"
}
