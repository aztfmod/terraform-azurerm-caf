resource "azurerm_virtual_machine_scale_set_extension" "daextension" {
  for_each                     = var.extension_name == "microsoft_azure_da_extension" ? toset(["enabled"]) : toset([])
  name                         = "microsoft_azure_da_extension"
  virtual_machine_scale_set_id = var.virtual_machine_scale_set_id
  publisher                    = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                         = "DependencyAgentLinux"
  type_handler_version         = try(var.extension.type_handler_version, "9.5")
  auto_upgrade_minor_version   = try(var.extension.auto_upgrade_minor_version, false)
}
