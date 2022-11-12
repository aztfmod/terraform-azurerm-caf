resource "azurerm_virtual_machine_extension" "vm_ext_mma" {
  for_each                   = var.extension_name == "azure_monitor_agent" ? toset(["enabled"]) : toset([])
  virtual_machine_id         = var.virtual_machine_id
  auto_upgrade_minor_version = try(var.extension.auto_upgrade_minor_version, null)
  automatic_upgrade_enabled  = try(var.extension.automatic_upgrade_enabled, null)
  name                       = var.virtual_machine_os_type == "linux" ? "AzureMonitorLinuxAgent" : "AzureMonitorWindowsAgent"
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = var.virtual_machine_os_type == "linux" ? "AzureMonitorLinuxAgent" : "AzureMonitorWindowsAgent"
  type_handler_version       = try(var.extension.type_handler_version, var.virtual_machine_os_type == "linux" ? "1.22" : "1.8")
}