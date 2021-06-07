# Tested with :  AzureRM version 2.61.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_replication_policy

resource "azurerm_site_recovery_replication_policy" "policy" {
  depends_on = [time_sleep.delay_create]
  for_each   = try(var.settings.replication_policies, {})

  name                                                 = each.value.name
  resource_group_name                                  = var.resource_group_name
  recovery_vault_name                                  = azurerm_recovery_services_vault.asr.name
  recovery_point_retention_in_minutes                  = each.value.recovery_point_retention_in_minutes
  application_consistent_snapshot_frequency_in_minutes = each.value.application_consistent_snapshot_frequency_in_minutes
}