resource "azurerm_virtual_machine_extension" "custom_script" {
  for_each                   = var.extension_name == "custom_script" ? toset(["enabled"]) : toset([])
  name                       = "custom_script"
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  auto_upgrade_minor_version = true

  settings = jsonencode(
    {
      fileUris  = local.fileuris,
      timestamp = try(var.extension.timestamp, "12345678")
    }
  )

  protected_settings = jsonencode(local.protected_settings)
}

locals {
  # managed identity
  identity_type           = try(var.extension.identity_type, "") #userassigned, systemassigned or null
  managed_local_identity  = try(var.managed_identities[var.client_config.landingzone_key][var.extension.managed_identity_key].principal_id, "")
  managed_remote_identity = try(var.managed_identities[var.extension.lz_key][var.extension.managed_identity_key].principal_id, "")
  provided_identity       = try(var.extension.managed_identity_id, "")
  managed_identity        = try(coalesce(local.managed_local_identity, local.managed_remote_identity, local.provided_identity), "")

  map_system_assigned = {
    managedIdentity = {}
  }
  map_user_assigned = {
    managedIdentity = {
      objectid = local.managed_identity
    }
  }
  map_command = {
    commandToExecute = try(var.extension.commandtoexecute, "")
  }

  system_assigned_id = local.identity_type == "SystemAssigned" ? local.map_system_assigned : null
  user_assigned_id   = local.identity_type == "UserAssigned" ? local.map_user_assigned : null

  protected_settings = merge(local.map_command, local.system_assigned_id, local.user_assigned_id)

  # fileuris
  fileuri_sa_key  = try(var.extension.fileuri_sa_key, "")
  fileuri_sa_path = try(var.extension.fileuri_sa_path, "")
  fileuri_sa = local.fileuri_sa_key != "" ? try(
    try(var.storage_accounts[var.client_config.landingzone_key][var.extension.fileuri_sa_key].primary_blob_endpoint, null),
    try(var.storage_accounts[var.extension.lz_key][var.extension.fileuri_sa_key].primary_blob_endpoint, null)
  ) : ""
  fileuri_sa_full_path = "${local.fileuri_sa}${local.fileuri_sa_path}"
  fileuri_sa_defined   = try(var.extension.fileuris, "")
  fileuris             = local.fileuri_sa_defined == "" ? [local.fileuri_sa_full_path] : var.extension.fileuris
}
