resource "azurerm_user_assigned_identity" "msi" {
  for_each = var.managed_identities

  resource_group_name = azurerm_resource_group.rg[each.value.resource_group_key].name
  location            = azurerm_resource_group.rg[each.value.resource_group_key].location

  name = each.value.name

}

