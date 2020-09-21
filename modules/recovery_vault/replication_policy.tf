# resource "azurecaf_name" "policy" {
#   for_each = var.settings.replication_policies

#   name          = each.value.name
#   resource_type = "azurerm_site_recovery_replication_policy"
#   #TODO: name policy
#   prefixes      = [var.global_settings.prefix]
#   random_length = var.global_settings.random_length
#   clean_input   = true
#   passthrough   = var.global_settings.passthrough
# }

resource "azurerm_site_recovery_replication_policy" "policy" {
  depends_on = [azurerm_recovery_services_vault.asr_rg_vault]
  for_each   = try(var.settings.replication_policies, {})

  name                                                 = each.value.name
  resource_group_name                                  = var.resource_group_name
  recovery_vault_name                                  = azurerm_recovery_services_vault.asr_rg_vault.name
  recovery_point_retention_in_minutes                  = each.value.recovery_point_retention_in_minutes
  application_consistent_snapshot_frequency_in_minutes = each.value.application_consistent_snapshot_frequency_in_minutes
}