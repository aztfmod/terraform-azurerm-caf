# Tested with :  AzureRM version 2.61.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_protection_container

resource "azurerm_site_recovery_protection_container" "protection_container" {
  for_each = try(var.settings.protection_containers, {})

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  recovery_vault_name  = azurerm_recovery_services_vault.asr.name
  recovery_fabric_name = azurerm_site_recovery_fabric.recovery_fabric[each.value.recovery_fabric_key].name
}

# Tested with :  AzureRM version 2.61.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_protection_container_mapping

resource "azurerm_site_recovery_protection_container_mapping" "container-mapping" {
  for_each = try(var.settings.protection_container_mapping, {})

  name                                      = each.value.name
  resource_group_name                       = var.resource_group_name
  recovery_vault_name                       = azurerm_recovery_services_vault.asr.name
  recovery_fabric_name                      = azurerm_site_recovery_fabric.recovery_fabric[each.value.fabric_key].name
  recovery_source_protection_container_name = azurerm_site_recovery_protection_container.protection_container[each.value.source_protection_container_key].name
  recovery_target_protection_container_id   = azurerm_site_recovery_protection_container.protection_container[each.value.target_protection_container_key].id
  recovery_replication_policy_id            = azurerm_site_recovery_replication_policy.policy[each.value.policy_key].id
}