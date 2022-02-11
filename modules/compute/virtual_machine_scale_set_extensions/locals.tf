locals {
  identity_type           = try(var.extension.identity_type, "") # userassigned, systemassigned or null
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
}
