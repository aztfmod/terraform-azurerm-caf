resource "azurerm_firewall" "fw" {
  for_each = lookup(var.networking, "azurerm_firewalls", {})

  name                = each.value.name
  resource_group_name = azurerm_resource_group.rg[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  threat_intel_mode   = try(each.value.threat_intel_mode, "Alert")
  zones               = try(each.value.zones, null)
  tags                = try(each.value.tags, null)

  ip_configuration {
    name                 = "configuration"
    subnet_id            = module.networking[each.value.vnet_key].subnets["AzureFirewallSubnet"].id
    public_ip_address_id = module.public_ip_addresses[each.value.public_ip_key].id
  }
}