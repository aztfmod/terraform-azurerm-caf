
resource "azurecaf_naming_convention" "rg" {
  for_each = var.resource_groups

  name          = each.value.name
  resource_type = "azurerm_resource_group"
  convention    = lookup(each.value, "convention", var.global_settings.convention)
  prefix        = lookup(each.value, "useprefix", false) ? var.global_settings.prefix : ""
  max_length    = lookup(each.value, "max_length", null)
}

resource "azurerm_resource_group" "rg" {
  for_each = var.resource_groups

  name     = azurecaf_naming_convention.rg[each.key].result
  location = var.global_settings.regions[lookup(each.value, "region", var.global_settings.default_region)]
  tags     = merge(lookup(each.value, "tags", {}), var.tags)
}

output resource_groups {
  value     = azurerm_resource_group.rg
  sensitive = true
}
