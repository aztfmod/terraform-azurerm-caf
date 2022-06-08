resource "azurerm_virtual_machine_extension" "aadjoin" {
  for_each                   = var.extension_name == "microsoft_azure_aadjoin" ? toset(["enabled"]) : toset([])
  name                       = "microsoft_azure_aadjoin"
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADLoginForWindows"
  type_handler_version       = try(var.extension.type_handler_version, "1.0")
  auto_upgrade_minor_version = try(var.extension.auto_upgrade_minor_version, true)
}
