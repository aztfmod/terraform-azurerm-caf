resource "azurerm_virtual_machine_extension" "genext" {
  for_each = {
    for key, value in var.extension : key => value
    if var.extension_name == "generic_extension"
  }

  virtual_machine_id          = var.virtual_machine_id
  name                        = try(each.value.name, null)
  publisher                   = try(each.value.publisher, null)
  type                        = try(each.value.type, null)
  type_handler_version        = try(each.value.type_handler_version, null)
  auto_upgrade_minor_version  = try(each.value.auto_upgrade_minor_version, null)
  automatic_upgrade_enabled   = try(each.value.automatic_upgrade_enabled, null)
  failure_suppression_enabled = try(each.value.failure_suppression_enabled, null)

  settings           = try(each.value.settings, null)
  protected_settings = try(each.value.protected_settings, null)

  lifecycle {
    precondition {
      condition = anytrue(
        [
          for status in jsondecode(data.azapi_resource_action.azurerm_virtual_machine_status.output).statuses : "true"
          if status.code == "PowerState/running"
        ]
      )
      error_message = format("The virtual machine (%s) must be in running state to be able to deploy or modify the vm extension.", var.virtual_machine_id)
    }
  }
}
