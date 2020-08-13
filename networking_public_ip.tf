## Azure Firewall configuration
module "az_firewall_ip" {
  for_each = var.firewalls

  source = "github.com/aztfmod/terraform-azurerm-caf-public-ip?ref=vnext"
  # source  = "aztfmod/caf-public-ip/azurerm"
  # version = "2.0.0"

  convention                 = lookup(each.value, "convention", var.global_settings.convention)
  name                       = each.value.firewall_ip_addr_config.ip_name
  location                   = each.value.location
  resource_group_name        = azurerm_resource_group.rg[each.value.resource_group_key].name
  ip_addr                    = each.value.firewall_ip_addr_config
  tags                       = var.tags
  diagnostics_map            = var.caf_foundations_accounting[each.value.location].diagnostics_map
  log_analytics_workspace_id = var.caf_foundations_accounting[each.value.location].log_analytics_workspace.id
  diagnostics_settings       = each.value.firewall_ip_addr_config.diagnostics
}