resource "azurerm_site_recovery_fabric" "recovery_fabric" {
  for_each = try(var.settings.recovery_fabrics, {})

  name                = each.value.name
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.asr_rg_vault.name
  location            = var.global_settings.regions[each.value.region]
}