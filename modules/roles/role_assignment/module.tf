

module "assignment" {
  source   = "./assignment"
  for_each = var.role_mappings

  scope                = var.scope
  role_definition_name = var.mode == "built-in" ? each.key : null
  role_definition_id   = var.mode == "custom" ? var.custom_roles[each.key].role_definition_resource_id : null
  keys                 = each.value
  azuread_apps         = var.azuread_apps
  azuread_groups       = var.azuread_groups
  managed_identities   = var.managed_identities
  client_config        = var.client_config
}

