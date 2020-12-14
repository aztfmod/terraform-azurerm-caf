resource "azurerm_site_recovery_fabric" "recovery_fabric" {
  depends_on = [azurerm_recovery_services_vault.asr, time_sleep.delay_create]
  for_each   = try(var.settings.recovery_fabrics, {})

  name                = each.value.name
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurecaf_name.asr_rg_vault.result
  location            = var.global_settings.regions[each.value.region]
}