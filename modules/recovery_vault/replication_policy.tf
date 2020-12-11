
resource "azurerm_site_recovery_replication_policy" "policy" {
  depends_on = [azurerm_recovery_services_vault.asr, time_sleep.delay_create]
  for_each   = try(var.settings.replication_policies, {})

  name                                                 = each.value.name
  resource_group_name                                  = var.resource_group_name
  recovery_vault_name                                  = azurecaf_name.asr_rg_vault.result
  recovery_point_retention_in_minutes                  = each.value.recovery_point_retention_in_minutes
  application_consistent_snapshot_frequency_in_minutes = each.value.application_consistent_snapshot_frequency_in_minutes
}