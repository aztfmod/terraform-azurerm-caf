resource "azurecaf_name" "ise" {
  name          = var.settings.name
  resource_type = "azurerm_integration_service_environment"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
# Last review :  AzureRM version 2.74.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/integration_service_environment
resource "azurerm_integration_service_environment" "ise" {
  name                 = azurecaf_name.ise.result
  resource_group_name  = var.resource_group_name
  location             = var.location
  sku_name             = var.settings.sku_name
  access_endpoint_type = var.settings.access_endpoint_type
  tags                 = merge(local.tags, lookup(var.settings, "tags", {}))
  virtual_network_subnet_ids = try(var.settings.subnets, null) == null ? null : [
    for key, value in var.settings.subnets : var.vnets[try(value.lz_key, var.client_config.landingzone_key)][value.vnet_key].subnets[value.subnet_key].id
  ]
}

