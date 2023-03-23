locals {
  identity_ids = can(var.settings.identity.identity_keys) ? flatten([
    for k, v in var.settings.identity.identity_keys : [
      try(
        v.identity_id,
        var.remote_objects.managed_identities[try(v.lz_key, var.client_config.landingzone_key)][v.identity_key].id
      )
    ]
  ]) : null
}
