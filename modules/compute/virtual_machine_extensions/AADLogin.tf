resource "azurerm_virtual_machine_extension" "AADLogin" {
  for_each                   = var.extension_name == "AADLogin" ? toset(["enabled"]) : toset([])
  name                       = "AADLogin"
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = local.aadlogin_publisher
  type                       = local.aadlogin_type
  #type_handler_version       = local.type_handler_version
  auto_upgrade_minor_version = true
}

locals {
  aadlogin_publisher            = "Microsoft.Azure.ActiveDirectory"
  #type_handler_version = var.virtual_machine_os_type == "linux" ? "2.1" : "1.10"
  aadlogin_type                 = var.virtual_machine_os_type == "linux" ? "AADSSHLoginForLinux" : "AADLoginForWindows"
}
