# Resorce type doesn't "azurerm_logic_app_workflow" doesn't exist in azurecaf!!
# resource "azurecaf_name" "integration_service_environment" {
#   name          = var.name
#   resource_type = "azurerm_integration_service_environment"
#   prefixes      = [var.global_settings.prefix]
#   random_length = var.global_settings.random_length
#   clean_input   = true
#   passthrough   = var.global_settings.passthrough
#   use_slug      = var.global_settings.use_slug
# }

resource "azurerm_integration_service_environment" "ise" {
  name                       = var.name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  sku_name                   = var.sku_name
  access_endpoint_type       = var.access_endpoint_type
  virtual_network_subnet_ids = var.virtual_network_subnet_ids
  tags                       = merge(var.tags, var.base_tags)
}

