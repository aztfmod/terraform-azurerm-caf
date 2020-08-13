# module firewalls {
#   source "./modules/networking/firewall"

#   for_each = var.firewalls

#   convention           = lookup(each.value, "convention", var.global_settings.convention)
#   name                 = each.value.az_fw_config.name
#   resource_group_name  = azurerm_resource_group.rg[each.value.resource_group_key].name
#   subnet_id            = module.vnets[each.value.vnet_key].vnet_subnets["AzureFirewallSubnet"]
#   public_ip_id         = module.az_firewall_ip[each.key].id
#   location             = each.value.location
#   tags                 = local.tags
#   diagnostics_map      = local.caf_foundations_accounting[each.value.location].diagnostics_map
#   la_workspace_id      = local.caf_foundations_accounting[each.value.location].log_analytics_workspace.id
#   diagnostics_settings = each.value.az_fw_config.diagnostics

# }