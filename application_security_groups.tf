module "application_security_groups" {
  source = "./modules/networking/application_security_group"

  for_each = local.networking.application_security_groups

  settings            = each.value
  global_settings     = local.global_settings
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]

}

output "application_security_groups" {
  value = module.application_security_groups

}

