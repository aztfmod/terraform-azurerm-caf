#TODO
# resource "azurerm_site_recovery_network_mapping" "network_mapping" {
#   for_each = try(var.settings.recovery_fabrics, {})

#   name                        = each.value.name
#   resource_group_name         = var.resource_group_name
#   recovery_vault_name         = azurerm_recovery_services_vault.asr_rg_vault.name
#   source_recovery_fabric_name = azurerm_site_recovery_fabric.recovery_fabric[each.value.source_recovery_fabric_key].name
#   target_recovery_fabric_name = azurerm_site_recovery_fabric.recovery_fabric[each.value.target_recovery_fabric_key].name
#   source_network_id           = azurerm_virtual_network.primary.id
#   target_network_id           = azurerm_virtual_network.secondary.id
# }