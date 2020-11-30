module shared_image_gallery {
  source   = "./modules/shared_image_gallery/image_galleries"
  for_each = try(local.shared_services.shared_image_galleries, {})

  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  diagnostics         = local.diagnostics
  client_config       = local.client_config
  global_settings     = local.global_settings
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}

}

module image_definitions {
  source   = "./modules/shared_image_gallery/image_definitions"
  for_each = try(local.shared_services.image_definitions, {})

  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  diagnostics         = local.diagnostics
  client_config       = local.client_config
  global_settings     = local.global_settings
  gallery_name = module.shared_image_gallery[each.value.gallery_key].name
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}

}

