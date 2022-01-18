terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}

locals {
  server_name = "${var.server_name}${var.cloud.sqlServerHostname}"

  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(local.module_tag, try(var.settings.tags, null), var.base_tags)
  db_permissions = {
    for group_key, group in try(var.settings.db_permissions, {}) : group_key => {
      db_roles = group.db_roles
      db_usernames = flatten([
        for lz_key, value in group.managed_identities : [
          for managed_identity_key in value.managed_identity_keys : [var.managed_identities[lz_key][managed_identity_key].name]
        ]
      ])
    }
  }
}
