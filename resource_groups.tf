
# resource "azurecaf_naming_convention" "rg" {
#   for_each = var.resource_groups

#   name          = each.value.name
#   resource_type = "azurerm_resource_group"
#   convention    = try(each.value.convention, local.global_settings.convention)
#   prefix        = lookup(each.value, "useprefix", true) == false ? "" : local.global_settings.prefix
#   max_length    = try(each.value.max_length, local.global_settings.max_length)
# }

# resource "azurerm_resource_group" "rg" {
#   for_each = var.resource_groups

#   name     = azurecaf_naming_convention.rg[each.key].result
#   location = local.global_settings.regions[lookup(each.value, "region", local.global_settings.default_region)]
#   tags     = merge(var.tags, lookup(each.value, "tags", {}))
# }

module resource_groups {
  source   = "./modules/resource_group"
  for_each = var.resource_groups

  resource_group_name = each.value.name
  settings            = each.value
  global_settings     = local.global_settings
  tags                = var.tags
}

output resource_groups {
  value     = module.resource_groups
  sensitive = true
}