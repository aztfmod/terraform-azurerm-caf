resource "azurerm_virtual_machine_scale_set_extension" "vmss_ext_da" {
  for_each                     = var.extension_name == "dependency_agent" ? toset(["enabled"]) : toset([])
  virtual_machine_scale_set_id = var.virtual_machine_scale_set_id
  auto_upgrade_minor_version   = try(var.extension.auto_upgrade_minor_version, null)
  name                         = var.virtual_machine_scale_set_os_type == "linux" ? "DependencyAgentLinux" : "DependencyAgentWindows"
  publisher                    = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                         = var.virtual_machine_scale_set_os_type == "linux" ? "DependencyAgentLinux" : "DependencyAgentWindows"
  type_handler_version         = try(var.extension.type_handler_version, null)

  settings = jsonencode({
    "enableAutomaticUpgrade" = true
  })
}

