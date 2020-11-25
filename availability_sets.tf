module availability_sets {
  source   = "./modules/compute/availability_set"
  for_each = local.compute.availability_sets

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  name                = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  availability_sets   = local.compute.availability_sets
}


output availability_sets {
  value     = module.availability_sets
  sensitive = true
}