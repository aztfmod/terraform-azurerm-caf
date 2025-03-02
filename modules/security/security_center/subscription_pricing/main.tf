resource "azurerm_security_center_subscription_pricing" "pricing" {
  # Free or Standard
  tier = var.tier
  # Depends on the resource_type
  subplan = try(var.subplan, null)
  # can be one of: Api, AppServices, Arm, CloudPosture, ContainerRegistry, Containers, CosmosDbs, Dns, KeyVaults, KubernetesService, OpenSourceRelationalDatabases, SqlServers, SqlServerVirtualMachines, StorageAccounts, VirtualMachines
  resource_type = var.resource_type

  # extensions list : https://learn.microsoft.com/en-us/rest/api/defenderforcloud/pricings/get?view=rest-defenderforcloud-2024-01-01&tabs=HTTP#extension
  dynamic "extension" {
    for_each = coalesce(var.extensions, {})
    content {
      name                            = extension.value.name
      additional_extension_properties = try(extension.value.additional_extension_properties, null)
    }
  }
}
