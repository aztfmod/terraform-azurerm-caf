# TODO: pending support of this resource type: https://github.com/aztfmod/terraform-provider-azurecaf/issues/76
# resource "azurecaf_name" "wvdpool" {
#   name          = var.name
#   resource_type = "azurerm_virtual_desktop_host_pool"
#   prefixes      = [var.global_settings.prefix]
#   random_length = var.global_settings.random_length
#   clean_input   = true
#   passthrough   = var.global_settings.passthrough
#   use_slug      = var.global_settings.use_slug
# }

resource "azurerm_virtual_desktop_host_pool" "wvdpool" {
  location            = var.location
  resource_group_name = var.resource_group_name
  #TODO: pending support of this resource type: https://github.com/aztfmod/terraform-provider-azurecaf/issues/76
  #name = azurecaf_name.wvdpool.result
  name                             = var.settings.name
  friendly_name                    = try(var.settings.friendly_name, null)
  description                      = try(var.settings.description, null)
  validate_environment             = try(var.settings.validate_environment, null)
  type                             = var.settings.type
  maximum_sessions_allowed         = try(var.settings.maximum_sessions_allowed, null)
  load_balancer_type               = try(var.settings.load_balancer_type, null)
  personal_desktop_assignment_type = try(var.settings.personal_desktop_assignment_type, null)
  preferred_app_group_type         = try(var.settings.preferred_app_group_type, null)
  custom_rdp_properties            = try(var.settings.custom_rdp_properties, null)
  tags                             = local.tags

  dynamic "registration_info" {
    for_each = try(var.settings.registration_info, null) == null ? [] : [1]

    content {
      expiration_date = try(var.settings.registration_info.expiration_date, null)
    }
  }

}

