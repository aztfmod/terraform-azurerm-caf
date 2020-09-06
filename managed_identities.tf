
module managed_identities {
  source   = "./modules/security/managed_identity"
  for_each = var.managed_identities

  name                = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = module.resource_groups[each.value.resource_group_key].location
}