
resource "azurecaf_naming_convention" "rg" {
  for_each = var.resource_groups

  name          = each.value.name
  resource_type = "azurerm_resource_group"
  convention    = lookup(each.value, "convention", local.global_settings.convention)
  prefix        = lookup(each.value, "useprefix", true) == false ? "" : local.global_settings.prefix
  max_length    = lookup(each.value, "max_length", local.global_settings.max_length)
}

resource "azurerm_resource_group" "rg" {
  for_each = var.resource_groups

  name     = azurecaf_naming_convention.rg[each.key].result
  location = local.global_settings.regions[lookup(each.value, "region", local.global_settings.default_region)]
  tags     = merge(lookup(each.value, "tags", {}), var.tags)
}

output resource_groups {
  value     = azurerm_resource_group.rg
  sensitive = true
}
