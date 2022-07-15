
resource "azurerm_virtual_machine_scale_set_extension" "adf_shir" {
  for_each                     = var.extension_name == "data_factory_self_hosted_integration_runtime" && var.virtual_machine_scale_set_os_type == "windows" ? toset(["enabled"]) : toset([])
  name                         = "custom_script"
  virtual_machine_scale_set_id = var.virtual_machine_scale_set_id
  type                         = local.type
  publisher                    = local.publisher
  type_handler_version         = local.type_handler_version
  auto_upgrade_minor_version   = try(var.extension.auto_upgrade_minor_version, true)
  automatic_upgrade_enabled    = try(var.extension.automatic_upgrade_enabled, null)


  settings = jsonencode(
    {
      "fileUris" : local.fileuris,
      "timestamp" : try(toint(var.extension.timestamp), 12345678)
    }
  )

  protected_settings = jsonencode(local.shir_vmss_ext_protected_settings)
}

locals {
  command_override       = try(var.extension.command_override, "")
  shir_vmss_base_command = try(var.extension.base_command_to_execute, "")
  shir_vmss_auth_key     = try(var.remote_objects.data_factory_integration_runtime_self_hosted[try(var.extension.data_factory_self_hosted_integration_runtime.lz_key, var.client_config.landingzone_key)][var.extension.data_factory_self_hosted_integration_runtime.key].auth_key_1, var.remote_objects.data_factory_integration_runtime_self_hosted[try(var.extension.data_factory_self_hosted_integration_runtime.lz_key, var.client_config.landingzone_key)][var.extension.data_factory_self_hosted_integration_runtime.key].auth_key_2, "")
  shir_vmss_ext_map_command = {
    commandToExecute = local.command_override == "" ? "${local.shir_vmss_base_command} ${local.shir_vmss_auth_key}" : local.command_override
  }
  shir_vmss_ext_protected_settings = merge(local.shir_vmss_ext_map_command, local.system_assigned_id, local.user_assigned_id)
}
