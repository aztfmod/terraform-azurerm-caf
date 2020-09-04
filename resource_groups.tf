
module resource_groups {
  source   = "./modules/resource_group"
  for_each = var.resource_groups

  resource_group_name = each.value.name
  settings            = each.value
  global_settings     = local.global_settings
  tags                = var.tags
}

output resource_groups {
  value     = module.resource_groups
  sensitive = true
}