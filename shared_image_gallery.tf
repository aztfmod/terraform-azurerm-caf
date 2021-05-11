module "shared_image_galleries" {
  source   = "./modules/shared_image_gallery/image_galleries"
  for_each = try(local.shared_services.shared_image_galleries, {})

  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  diagnostics         = local.diagnostics
  client_config       = local.client_config
  global_settings     = local.global_settings
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  depends_on = [
    module.keyvaults,
  ]
}

module "image_definitions" {
  source   = "./modules/shared_image_gallery/image_definitions"
  for_each = try(local.shared_services.image_definitions, {})

  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  diagnostics         = local.diagnostics
  client_config       = local.client_config
  global_settings     = local.global_settings
  gallery_name        = module.shared_image_galleries[each.value.gallery_key].name
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}

}

module "packer_service_principal" {
  source   = "./modules/shared_image_gallery/packer_service_principal"
  for_each = try(local.shared_services.packer_service_principal, {})

  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  client_config       = local.client_config
  global_settings     = local.global_settings
  subscription        = data.azurerm_subscription.primary.subscription_id
  tenant_id           = data.azurerm_client_config.current.tenant_id
  gallery_name        = module.shared_image_galleries[each.value.shared_image_gallery_destination.gallery_key].name
  image_name          = module.image_definitions[each.value.shared_image_gallery_destination.image_key].name
  key_vault_id        = lookup(each.value, "keyvault_key") == null ? null : module.keyvaults[each.value.keyvault_key].id
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  depends_on = [
    module.shared_image_galleries,
    module.image_definitions,
    azurerm_role_assignment.for,
  ]
}