
resource "azurerm_data_protection_resource_guard" "resource_guard" {
  count               = can(var.settings.resource_guard) ? 1 : 0 
  name                = var.settings.resource_guard.name
  resource_group_name = local.resource_group_name
  location            = local.location
  #List of critical operations which are NOT protected by this resourceGuard.
  vault_critical_operation_exclusion_list = try(var.settings.resource_guard.vault_critical_operation_exclusion_list, null)
}

resource "azurerm_recovery_services_vault_resource_guard_association" "resource_guard_association" {
  count             = can(var.settings.resource_guard) ? 1 : 0 
  vault_id          = azurerm_recovery_services_vault.asr.id
  resource_guard_id = azurerm_data_protection_resource_guard.resource_guard[0].id
}