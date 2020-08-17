

module assignment {
  source   = "/tf/caf/modules/role_assignment/assignment"
  for_each = var.role_mappings

  scope                = var.scope
  role_definition_name = each.key
  keys                 = each.value
  azuread_apps         = var.azuread_apps
  azuread_groups       = var.azuread_groups
  managed_identities   = var.managed_identities
}
