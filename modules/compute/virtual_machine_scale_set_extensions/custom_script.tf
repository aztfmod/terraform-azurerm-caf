resource "azurerm_virtual_machine_scale_set_extension" "custom_script" {
  for_each                     = var.extension_name == "custom_script" ? toset(["enabled"]) : toset([])
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

  provision_after_extensions = try(var.extension.provision_after_extensions, null)
  protected_settings         = jsonencode(local.protected_settings)
}

locals {
  managed_local_identity_principal_id  = try(var.managed_identities[var.client_config.landingzone_key][var.extension.managed_identity_key].principal_id, "")
  managed_remote_identity_principal_id = try(var.managed_identities[var.extension.lz_key][var.extension.managed_identity_key].principal_id, "")
  provided_identity_principal_id       = try(var.extension.managed_identity_id, "")
  managed_identity_principal_id        = try(coalesce(local.managed_local_identity_principal_id, local.managed_remote_identity_principal_id, local.provided_identity_principal_id), "")

  publisher            = var.virtual_machine_scale_set_os_type == "linux" ? "Microsoft.Azure.Extensions" : "Microsoft.Compute"
  type_handler_version = var.virtual_machine_scale_set_os_type == "linux" ? "2.1" : "1.10"
  type                 = var.virtual_machine_scale_set_os_type == "linux" ? "CustomScript" : "CustomScriptExtension"

  map_system_assigned = {
    managedIdentity = {}
  }

  map_user_assigned = {
    managedIdentity = {
      objectid = local.managed_identity_principal_id
    }
  }

  map_command = {
    commandToExecute = try(var.extension.commandtoexecute, "")
  }

  identity_type      = try(var.extension.identity_type, "") # userassigned, systemassigned or null
  system_assigned_id = local.identity_type == "SystemAssigned" ? local.map_system_assigned : null
  user_assigned_id   = local.identity_type == "UserAssigned" ? local.map_user_assigned : null

  protected_settings = merge(local.map_command, local.system_assigned_id, local.user_assigned_id)

  # Fileuris
  fileuris             = local.fileuri_sa_defined == "" ? [local.fileuri_sa_full_path] : var.extension.fileuris
  fileuri_sa_key       = try(var.extension.fileuri_sa_key, "")
  fileuri_sa_path      = try(var.extension.fileuri_sa_path, "")
  fileuri_sa           = local.fileuri_sa_key != "" ? try(var.storage_accounts[var.client_config.landingzone_key][var.extension.fileuri_sa_key].primary_blob_endpoint, try(var.storage_accounts[var.extension.lz_key][var.extension.fileuri_sa_key].primary_blob_endpoint)) : ""
  fileuri_sa_full_path = "${local.fileuri_sa}${local.fileuri_sa_path}"
  fileuri_sa_defined   = try(var.extension.fileuris, "")
}
