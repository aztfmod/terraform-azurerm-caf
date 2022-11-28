locals {
  managed_local_identities = flatten([
    for managed_identity_key in try(var.settings.identity.managed_identity_keys, []) : [
      var.managed_identities[var.client_config.landingzone_key][managed_identity_key].id
    ]
  ])

  managed_remote_identities = flatten([
    for keyvault_key, value in try(var.settings.identity.remote, []) : [
      for managed_identity_key in value.managed_identity_keys : [
        var.managed_identities[keyvault_key][managed_identity_key].id
      ]
    ]
  ])

  managed_identities = concat(local.managed_local_identities, local.managed_remote_identities)
}
