## App Configuration

resource "azurecaf_name" "app_config" {
  name          = var.name
  resource_type = "azurerm_app_configuration"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Create config data store resource
resource "azurerm_app_configuration" "config" {
  name                = azurecaf_name.app_config.result
  resource_group_name = var.resource_group_name
  sku                 = try(var.settings.sku_name, "standard")
  location            = var.location
  tags                = local.tags

  dynamic "identity" {
    for_each = lookup(var.settings, "identity", {}) == {} ? [] : [1]

    content {
      type = var.settings.identity.type
    }
  }
}
