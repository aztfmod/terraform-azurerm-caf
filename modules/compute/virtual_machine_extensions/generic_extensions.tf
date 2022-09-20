resource "azurerm_virtual_machine_extension" "genext" {
  for_each = {
    for key, value in var.extension : key => value
    if var.extension_name == "generic_extension"
  }

  virtual_machine_id   = var.virtual_machine_id
  name                 = try(each.value.name, null)
  publisher            = try(each.value.publisher, null)
  type                 = try(each.value.type, null)
  type_handler_version = try(each.value.type_handler_version, null)

  settings           = try(each.value.settings, null)
  protected_settings = try(each.value.protected_settings, null)
}