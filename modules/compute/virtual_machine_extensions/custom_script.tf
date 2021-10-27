resource "azurerm_virtual_machine_extension" "custom_script" {
  for_each                   = var.extension_name == "custom_script" ? toset(["enabled"]) : toset([])
  name                       = "custom_script"
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.10"
  auto_upgrade_minor_version = true

  settings                   = jsonencode(local.settings)
  protected_settings         = jsonencode(local.protected_settings)
}

locals {
  # managed identity
  identity_type = try(var.extension.identity_type, "") #userassigned, systemassigned or null
  managed_local_identity = try(var.managed_identities[var.client_config.landingzone_key][var.extension.managed_identity_key].princpal_id, "")
  managed_remote_identity = try(var.managed_identities[var.extension.lz_key][var.extension.managed_identity_key].principal_id, "")
  provided_identity = try(var.extension.managed_identity_id, "")
  managed_identity = coalesce(local.managed_local_identity, local.managed_remote_identity, local.provided_identity)
  
  system_assigned_id = local.identity_type == "SystemAssigned" ? {"managedIdentity" : {}} : null
  user_assigned_id = local.identity_type == "UserAssigned" ? {"managedIdentity" : {"objectid" : "${local.managed_identity}"}} : null
  
  command = {"commandtoexecute" : "${var.extension.commandtoexecute}"}

  protected_settings = merge(local.command,local.system_assigned_id,local.user_assigned_id)

  # fileuris
  fileuri_sa_key       = try(var.extension.fileuri_sa_key, "")
  fileuri_sa_path      = try(var.extension.fileuri_sa_path, "")
  fileuri_sa           = local.fileuri_sa_key != "" ? try(var.storage_accounts[var.client_config.landingzone_key][var.extension.fileuri_sa_key].primary_blob_endpoint, try(var.storage_accounts[var.extension.lz_key][var.extension.fileuri_sa_key].primary_blob_endpoint)) : ""
  fileuri_sa_full_path = "${local.fileuri_sa}${local.fileuri_sa_path}"

  timestamp = {"timestamp" : try(var.extension.timestamp, "12345678")}
  fileuri_sa_defined   = try(var.extension.fileuris, "")
  fileuris = fileuri_sa_defined == "" ? [local.fileuri_sa_full_path] : var.extension.fileuris
  settings = merge(local.timestamp,local.fileuris)
}