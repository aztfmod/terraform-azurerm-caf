resource "azurecaf_name" "wvdpool" {
  name          = var.settings.name
  resource_type = "azurerm_virtual_desktop_host_pool"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}


# Last review :  AzureRM version 2.97.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool

resource "azurerm_virtual_desktop_host_pool" "wvdpool" {
  location                         = var.location
  resource_group_name              = var.resource_group_name
  name                             = azurecaf_name.wvdpool.result
  friendly_name                    = try(var.settings.friendly_name, null)
  description                      = try(var.settings.description, null)
  validate_environment             = try(var.settings.validate_environment, null)
  type                             = var.settings.type
  maximum_sessions_allowed         = try(var.settings.maximum_sessions_allowed, null)
  load_balancer_type               = try(var.settings.load_balancer_type, null)
  personal_desktop_assignment_type = try(var.settings.personal_desktop_assignment_type, null)
  preferred_app_group_type         = try(var.settings.preferred_app_group_type, null)
  custom_rdp_properties            = try(var.settings.custom_rdp_properties, null)
  start_vm_on_connect              = try(var.settings.start_vm_on_connect, null)
  tags                             = local.tags
}

# Last review :  AzureRM version 2.97.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool_registration_info

resource "azurerm_virtual_desktop_host_pool_registration_info" "wvdpool" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.wvdpool.id
  expiration_date = try(var.settings.registration_info.expiration_date, timeadd(timestamp(), var.settings.registration_info.token_validity))
}
