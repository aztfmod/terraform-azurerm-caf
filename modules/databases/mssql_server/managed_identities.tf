locals {
  # create list of all managed identities ids associated with current landing zone
  managed_local_identities = flatten([
    for managed_identity_key in try(var.settings.identity.managed_identity_keys, []) : [
      var.managed_identities[var.client_config.landingzone_key][managed_identity_key].id
    ]
  ])
  # create list of all managed identities ids associated with remote lz
  managed_remote_identities = flatten([
    for keyvault_key, value in try(var.settings.identity.remote, []) : [
      for managed_identity_key in value.managed_identity_keys : [
        var.managed_identities[keyvault_key][managed_identity_key].id
      ]
    ]
  ])
  # consolidate lists if managed identiy ids
  managed_identities = concat(local.managed_local_identities, local.managed_remote_identities)
  # determine which identity will be primary identity; if only one managed identity, then use that
  # TODO: add logic to support specifying primary identity (needed when more than one identity defined)
  primary_user_assigned_identity_id = try(local.managed_identities[0], null)
}
