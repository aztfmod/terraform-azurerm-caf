
module automations {
  source   = "./modules/automation"
  for_each = local.shared_services.automations

  global_settings     = local.global_settings
  settings            = each.value
  diagnostics         = local.diagnostics
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : var.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

output automations {
  value     = module.automations
  sensitive = false
}
