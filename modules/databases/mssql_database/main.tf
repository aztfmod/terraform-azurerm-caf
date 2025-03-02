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
        [for mi_key, mi_value in group : [
          for value in try(mi_value.keys, mi_value.managed_identity_keys, []) : [
            try(var.managed_identities[mi_value.lz_key][value].name, var.managed_identities[var.client_config.landingzone_key][value].name)
          ]
        ] if mi_key == "managed_identities"],
        [for mi_key, mi_value in group : [
          for value in mi_value.keys : [
            try(var.azuread_groups[mi_value.lz_key][value].display_name, var.azuread_groups[var.client_config.landingzone_key][value].display_name)
          ]
        ] if mi_key == "azuread_groups"]
      ])
    }
  }
}
