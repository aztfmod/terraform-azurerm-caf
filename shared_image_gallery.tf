

#  resource "azurecaf_name" "sig_name" {
#    for_each =  local.shared_services.shared_image_gallery.galleries
#    name          = each.value.name
#    prefixes      = [local.global_settings.prefix]
#    resource_type = "azurerm_shared_image_gallery"
#   random_length = local.global_settings.random_length
#    clean_input   = true
#   passthrough   = local.global_settings.passthrough
#  }


// resource "azurecaf_name" "image_definition_name" {
//   for_each =  local.shared_services.shared_image_gallery.image_definition
//   name          = each.value.name
//   #prefixes      = [local.global_settings.prefix]
//   resource_type = "azurerm_shared_image"
//   random_length = local.global_settings.random_length
//   clean_input   = true
//   passthrough   = local.global_settings.passthrough
// }


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
  name     = each.value.name
  #azurecaf_name.image_definition_name[each.key].result
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
  template = file("${var.settings.packer.packer_variable_template_filepath}")
  vars {
    client_id             = azurerm_azuread_application.packer.application_id
    client_secret         = azurerm_azuread_application.packer.application_id
    tenant_id             = data.azurerm_client_config.current.tenant_id
    subscription_id       = data.azurerm_client_config.primary.subscription_id
    os_type               = var.settings.packer.os_type
    image_publisher       = var.settings.packer.image_publisher
    image_offer           = var.settings.packer.image_offer
    image_sku             = var.settings.packer.image_sku
    managed_image_name    = var.settings.shared_image_gallery
  }
  depends_on = [
    azurerm_shared_image_gallery.gallery
    azurerm_shared_image.image
  ]
}

resource "null_resource" "create_image" {
  provisioner "local-exec" {
    command = "packer build -var-file=${local.shared_services.packer.packer_configuration_file_path} ${local.shared_services.packer.packer_file_path}"
  }
  depends_on = [
    azurerm_shared_image.image
  ]
}

data "azurerm_managed_image" "managed_image_packer" {
  name = var.settings.packer.image_name
  depends_on = [
    null_resource.create-image
  ]
}

resource "null_resource" "delete_image" {
  provisioner "local-exec" {
    when = destroy
    commmand = "terraform destroy -target data.azurerm_managed_image.managed_image_packer"
  }
  depends_on = [
    azurerm_shared_image.image
  ]
}