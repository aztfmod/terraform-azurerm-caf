
resource "azurerm_private_dns_zone_virtual_network_link" "vnet_links" {
  for_each = var.vnet_links

  name                  = each.value.name
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns.name
  virtual_network_id    = try(each.value.lz_key, null) == null ? var.vnets[each.value.vnet_key].id : var.vnets[each.value.lz_key].vnets[each.value.vnet_key].id
}