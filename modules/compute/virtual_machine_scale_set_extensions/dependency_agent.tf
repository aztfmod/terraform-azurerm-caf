resource "azurerm_virtual_machine_scale_set_extension" "vmss_ext_da" {
  for_each                     = var.extension_name == "dependency_agent" ? toset(["enabled"]) : toset([])
  virtual_machine_scale_set_id = var.virtual_machine_scale_set_id
  auto_upgrade_minor_version   = true
  name                         = "DependencyAgentWindows"
  publisher                    = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                         = "DependencyAgentWindows"
  type_handler_version         = "9.10"
  provision_after_extensions = [var.vmss_extension_microsoft_monitoring_agent_extension_name]

  settings = jsonencode({
    "enableAutomaticUpgrade" = true
  })
}

