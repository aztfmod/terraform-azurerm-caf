# naming convention
resource "azurecaf_name" "wp" {
  name          = var.settings.name
  resource_type = "azurerm_databricks_workspace"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Databricks workspace
resource "azurerm_databricks_workspace" "ws" {
  name                        = azurecaf_name.wp.result
  resource_group_name         = var.resource_group_name
  location                    = var.location
  sku                         = try(var.settings.sku, "standard")
  managed_resource_group_name = try(var.settings.managed_resource_group_name, null)
  tags                        = try(local.tags, null)

  dynamic "custom_parameters" {
    for_each = try(var.settings.custom_parameters, null) == null ? [] : [1]

    content {
      no_public_ip        = try(var.settings.custom_parameters.no_public_ip, false)
      public_subnet_name  = try(var.vnets[var.client_config.landingzone_key][var.settings.custom_parameters.vnet_key].subnets[var.settings.custom_parameters.public_subnet_key].name, var.vnets[var.settings.custom_parameters.lz_key][var.settings.custom_parameters.vnet_key].subnets[var.settings.custom_parameters.public_subnet_key].name)
      private_subnet_name = try(var.vnets[var.client_config.landingzone_key][var.settings.custom_parameters.vnet_key].subnets[var.settings.custom_parameters.private_subnet_key].name, var.vnets[var.settings.custom_parameters.lz_key][var.settings.custom_parameters.vnet_key].subnets[var.settings.custom_parameters.private_subnet_key].name)
      virtual_network_id  = try(var.vnets[var.client_config.landingzone_key][var.settings.custom_parameters.vnet_key].id, var.vnets[var.settings.custom_parameters.lz_key][var.settings.custom_parameters.vnet_key].id)
    }
  }
}
