
module managed_identities {
  source   = "./modules/security/managed_identity"
  for_each = var.managed_identities

  name                = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = module.resource_groups[each.value.resource_group_key].location
  global_settings     = local.global_settings
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

output managed_identities {
  value     = module.managed_identities
  sensitive = true
}
