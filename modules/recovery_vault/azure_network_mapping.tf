resource "azurerm_site_recovery_network_mapping" "network_mapping" {
  for_each                    = try(var.settings.network_mappings, {})
  name                        = each.value.name
  resource_group_name         = var.resource_group_name
  recovery_vault_name         = azurerm_recovery_services_vault.asr.name
  source_recovery_fabric_name = azurerm_site_recovery_fabric.recovery_fabric[each.value.source_recovery_fabric_key].name
  target_recovery_fabric_name = azurerm_site_recovery_fabric.recovery_fabric[each.value.target_recovery_fabric_key].name
  source_network_id = coalesce(
    try(each.value.source_network.id, null),
    try(var.vnets[var.client_config.landingzone_key][each.value.source_network.vnet_key].id, null),
    try(var.vnets[each.value.source_network.lz_key][each.value.source_network.vnet_key].id, null)
  )
  target_network_id = coalesce(
    try(each.value.target_network.id, null),
    try(var.vnets[var.client_config.landingzone_key][each.value.target_network.vnet_key].id, null),
    try(var.vnets[each.value.target_network.lz_key][each.value.target_network.vnet_key].id, null)
  )
}
