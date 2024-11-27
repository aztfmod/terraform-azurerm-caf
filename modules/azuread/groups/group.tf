resource "azuread_group" "group" {

  administrative_unit_ids = can(var.azuread_groups.administrative_unit_ids) || can(var.azuread_groups.administrative_units) == false ? try(var.azuread_groups.administrative_unit_ids, null) : local.administrative_unit_ids
  assignable_to_role      = try(var.azuread_groups.assignable_to_role, null)
  display_name            = var.global_settings.passthrough || try(var.azuread_groups.global_settings.passthrough, false) == true ? format("%s", local.display_name) : format("%s%s", try(format("%s-", var.global_settings.prefixes.0), ""), local.display_name)
  description             = lookup(var.azuread_groups, "description", null)
  prevent_duplicate_names = lookup(var.azuread_groups, "prevent_duplicate_names", null)
  owners                  = length(local.owners) > 0 ? local.owners : null
  // Note: This module is effected by these bugs:
  // https://github.com/hashicorp/terraform-provider-azuread/issues/464
  // https://github.com/microsoftgraph/msgraph-metadata/issues/92
  // tldr: If your group is initially owned by a service principal and you add a user to the owners, you are not able to remove the user from the owners again. At least one user has to stay owner.
  security_enabled  = try(var.azuread_groups.security_enabled, true)
  visibility        = try(var.azuread_groups.visibility, null)
  mail_enabled      = try(var.azuread_groups.mail_enabled, null)
  writeback_enabled = try(var.azuread_groups.writeback_enabled, null)

}
data "azuread_user" "main" {
  for_each            = try(toset(var.azuread_groups.owners.user_principal_names), {})
  user_principal_name = each.value
}

locals {
  owners = concat(
    try(tolist(var.azuread_groups.owners), []),
    local.ad_user_oids
  )
  ad_user_oids = [for user in try(var.azuread_groups.owners.user_principal_names, []) :
    data.azuread_user.main[user].object_id
  ]

  display_name = can(var.azuread_groups.display_name) ? var.azuread_groups.display_name : var.azuread_groups.name

  administrative_unit_ids = flatten(
    [
      for key, value in try(var.azuread_groups.administrative_units, {}) : [
        can(value.id) ? value.id : var.remote_objects.azuread_administrative_units[try(value.lz_key, var.client_config.landingzone_key)][value.key].object_id
      ]
    ]
  )
}
