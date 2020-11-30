module shared_image_galleries {
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
  gallery_name        = module.shared_image_galleries[each.value.gallery_key].name
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}

}

module packer_managed_identity {
  source   = "./modules/shared_image_gallery/packer_managed_identity"
  for_each = try(local.shared_services.packer_managed_identity, {})

  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  client_config       = local.client_config
  global_settings     = local.global_settings
  gallery_name        = module.shared_image_galleries[each.value.gallery_key].name
  image_name          = module.image_definitions[each.value.image_key].name
  key_vault_id        = lookup(each.value, "keyvault_key") == null ? null : module.keyvaults[each.value.keyvault_key].id
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  depends_on = [
    module.shared_image_galleries,
    module.image_definitions,
    module.keyvaults,
    module.keyvaults.azurerm_key_vault_secret,
    azurerm_role_assignment.for
  ]
}

module packer_service_principal {
  source   = "./modules/shared_image_gallery/packer_service_principal"
  for_each = try(local.shared_services.packer_service_principal, {})

  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  client_config       = local.client_config
  global_settings     = local.global_settings
  gallery_name        = module.shared_image_galleries[each.value.gallery_key].name
  image_name          = module.image_definitions[each.value.image_key].name
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  depends_on = [
    module.shared_image_galleries,
    module.image_definitions,
    module.keyvaults,
    module.keyvaults.azurerm_key_vault_secret,
    azurerm_role_assignment.for
  ]
}