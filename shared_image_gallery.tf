

#  resource "azurecaf_name" "sig_name" {
#    for_each =  local.shared_services.shared_image_gallery.galleries
#    name          = each.value.name
#    prefixes      = [local.global_settings.prefix]
#    resource_type = "azurerm_shared_image_gallery"
#   random_length = local.global_settings.random_length
#    clean_input   = true
#   passthrough   = local.global_settings.passthrough
#  }


resource "azurecaf_name" "image_definition_name" {
  for_each =  local.shared_services.shared_image_gallery.image_definition
  name          = each.value.name
  prefixes      = [local.global_settings.prefix]
  resource_type = "azurerm_shared_image"
  random_length = local.global_settings.random_length
  clean_input   = true
  passthrough   = local.global_settings.passthrough
}


resource "azurerm_shared_image_gallery" "gallery" {
  for_each = try(local.shared_services.shared_image_gallery.galleries, {})
  name     = each.value.name
  #azurecaf_name.sig_name[each.key].result
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = module.resource_groups[each.value.resource_group_key].location
  description         = each.value.description
}

resource "azurerm_shared_image" "image" {
  for_each = try(local.shared_services.shared_image_gallery.image_definition, {})
  name     = azurecaf_name.image_definition_name[each.key].result
  gallery_name        = azurerm_shared_image_gallery.gallery[each.value.gallery_key].name
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = module.resource_groups[each.value.resource_group_key].location
  os_type             = each.value.os_type
  identifier {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
  }
}


data "template_file" "packer_template" {
  for_each = try(local.shared_services.packer, {})
  template = file(each.value.packer_template_filepath)
  vars = {
    client_id                         = module.azuread_applications[each.value.azuread_apps_key].azuread_service_principal.id
    client_secret                     = module.azuread_applications[each.value.azuread_apps_key].azuread_service_principal_password.value
    tenant_id                         = data.azurerm_client_config.current.tenant_id
    subscription_id                   = data.azurerm_subscription.primary.subscription_id
    os_type                           = each.value.os_type
    image_publisher                   = each.value.image_publisher
    image_offer                       = each.value.image_offer
    image_sku                         = each.value.image_sku
    location                          = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
    vm_size                           = each.value.vm_size
    managed_image_resource_group_name = module.resource_groups[each.value.resource_group_key].name
    managed_image_name                = each.value.managed_image_name
    ansible_playbook_path             = each.value.ansible_playbook_path

    //shared_image_gallery destination values. If publishing to a different Subscription, change the following arguments and supply the values as variables
    subscription        = data.azurerm_subscription.primary.subscription_id
    resource_group      = module.resource_groups[each.value.shared_image_gallery_destination.resource_group_key].name
    gallery_name        = azurerm_shared_image_gallery.gallery[each.value.shared_image_gallery_destination.gallery_key].name
    image_name          = azurerm_shared_image.image[each.value.shared_image_gallery_destination.image_key].name
    image_version       = each.value.shared_image_gallery_destination.image_version
    replication_regions = each.value.shared_image_gallery_destination.replication_regions
  }
  depends_on = [
    azurerm_shared_image_gallery.gallery,
    azurerm_shared_image.image
  ]
}

resource "null_resource" "packer_configuration_generator" {
  for_each = try(local.shared_services.packer, {})
  provisioner "local-exec" {
    command = "cat > ${each.value.packer_configuration_filepath} <<EOL\n${data.template_file.packer_template[each.key].rendered}\nEOL"
  }
}


resource "null_resource" "create_image" {
  for_each = try(local.shared_services.packer, {})
  provisioner "local-exec" {
    command = "packer build ${each.value.packer_configuration_filepath}"
  }
  depends_on = [
    null_resource.packer_configuration_generator,
    azurerm_shared_image_gallery.gallery,
    azurerm_shared_image.image
  ]
}