resource "azuread_group" "group" {

  display_name            = var.global_settings.passthrough ? format("%s", var.azuread_groups.name) : format("%s%s", try(format("%s-", var.global_settings.prefixes.0), ""), var.azuread_groups.name)
  description             = lookup(var.azuread_groups, "description", null)
  prevent_duplicate_names = lookup(var.azuread_groups, "prevent_duplicate_names", null)
  owners                  = local.owners
  // Note: This module is effected by these bugs:
  // https://github.com/hashicorp/terraform-provider-azuread/issues/464
  // https://github.com/microsoftgraph/msgraph-metadata/issues/92
  // tldr: If your group is initially owned by a service principal and you add a user to the owners, you are not able to remove the user from the owners again. At least one user has to stay owner.

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
}

