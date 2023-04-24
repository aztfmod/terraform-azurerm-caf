# Terraform azurerm resource: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub_shared_access_policy

resource "azurecaf_name" "iothub_shared_access_policy" {
  name          = var.settings.name
  resource_type = "azurerm_iothub_shared_access_policy"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_iothub_shared_access_policy" "access_policy" {
  name                = azurecaf_name.iothub_shared_access_policy.result
  resource_group_name = local.resource_group_name
  iothub_name         = var.iothub_name

  registry_read   = try(var.settings.registry_read, null)
  registry_write  = try(var.settings.registry_write, null)
  service_connect = try(var.settings.service_connect, null)
  device_connect  = try(var.settings.device_connect, null)
}
