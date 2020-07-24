
module "virtual_network" {
  source = "github.com/aztfmod/terraform-azurerm-caf-virtual-network?ref=vnext"
  # source  = "aztfmod/caf-virtual-network/azurerm"
  # version = "~> 2.0.1"

  for_each = var.networking

  prefix                    = var.global_settings.prefix
  convention                = lookup( each.value, "convention", var.global_settings.convention)
  location                  = azurerm_resource_group.rg[each.value.resource_group_key].location
  resource_group_name       = azurerm_resource_group.rg[each.value.resource_group_key].name
  networking_object         = each.value
  tags                      = var.tags
  log_analytics_workspace   = var.caf_foundations_accounting[lookup(each.value, "location",  var.global_settings.default_location)].log_analytics_workspace
  diagnostics_map           = var.caf_foundations_accounting[lookup(each.value, "location",  var.global_settings.default_location)].diagnostics_map
  diagnostics_settings      = each.value.diagnostics
}

