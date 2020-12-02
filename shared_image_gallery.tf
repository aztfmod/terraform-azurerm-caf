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
  depends_on = [
    module.keyvaults,
    time_sleep.time_delay_01
  ]
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

resource "time_sleep" "time_delay_01" {
  create_duration = "180s"
  depends_on = [
    module.azuread_applications
  ]
}


resource "time_sleep" "time_delay_03" {
  destroy_duration = "60s"
}

module packer_managed_identity {
  source   = "./modules/shared_image_gallery/packer_managed_identity"
  for_each = try(local.shared_services.packer_managed_identity, {})

  resource_group_name      = module.resource_groups[each.value.resource_group_key].name
  location                 = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  client_config            = local.client_config
  global_settings          = local.global_settings
  subscription             = data.azurerm_subscription.primary.subscription_id
  tenant_id                = data.azurerm_client_config.current.tenant_id
  gallery_name             = module.shared_image_galleries[each.value.shared_image_gallery_destination.gallery_key].name
  image_name               = module.image_definitions[each.value.shared_image_gallery_destination.image_key].name
  key_vault_id             = lookup(each.value, "keyvault_key") == null ? null : module.keyvaults[each.value.keyvault_key].id
  ssh_private_pem_key_name = module.virtual_machines[each.value.vm_key].ssh_keys.ssh_private_key_pem
  public_ip_addresses      = local.combined_objects_public_ip_addresses
  settings                 = each.value
  base_tags                = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  depends_on = [
    module.shared_image_galleries,
    module.image_definitions,
    module.virtual_machines,
    module.keyvaults,
    time_sleep.time_delay_01,
    time_sleep.time_delay_01
  ]
}

module packer_service_principal {
  source   = "./modules/shared_image_gallery/packer_service_principal"
  for_each = try(local.shared_services.packer_service_principal, {})

  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  client_config       = local.client_config
  global_settings     = local.global_settings
  subscription        = data.azurerm_subscription.primary.subscription_id
  tenant_id           = data.azurerm_client_config.current.tenant_id
  gallery_name        = module.shared_image_galleries[each.value.shared_image_gallery_destination.gallery_key].name
  image_name          = module.image_definitions[each.value.shared_image_gallery_destination.image_key].name
  key_vault_id        = lookup(each.value, "keyvault_key") == null ? null : module.keyvaults[each.value.keyvault_key].id
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  depends_on = [
    module.shared_image_galleries,
    module.image_definitions,
    azurerm_role_assignment.for,
    time_sleep.time_delay_01
  ]
}