
resource "azurecaf_naming_convention" "rg" {
  name          = var.resource_group_name
  resource_type = "azurerm_resource_group"
  convention    = try(var.settings.convention, var.global_settings.convention)
  prefix        = lookup(var.settings, "useprefix", true) == false ? "" : var.global_settings.prefix
  max_length    = try(var.settings.max_length, var.global_settings.max_length)
}

resource "azurerm_resource_group" "rg" {
  name     = azurecaf_naming_convention.rg.result
  location = var.global_settings.regions[lookup(var.settings, "region", var.global_settings.default_region)]
  tags     = merge(var.tags, lookup(var.settings, "tags", {}))
}
