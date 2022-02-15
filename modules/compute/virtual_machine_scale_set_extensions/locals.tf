locals {
  managed_local_identity  = try(var.managed_identities[var.client_config.landingzone_key][var.extension.managed_identity_key].principal_id, "")
  managed_remote_identity = try(var.managed_identities[var.extension.lz_key][var.extension.managed_identity_key].principal_id, "")
  provided_identity       = try(var.extension.managed_identity_id, "")
  managed_identity        = try(coalesce(local.managed_local_identity, local.managed_remote_identity, local.provided_identity), "")
}
