output name {
  value     = azurerm_resource_group.rg.name
  sensitive = true
}

output location {
  value     = azurerm_resource_group.rg.location
  sensitive = true
}

output tags {
  value     = azurerm_resource_group.rg.tags
  sensitive = true
}

output rbac_id {
  value = azurerm_resource_group.rg.id
}

output id {
  value = azurerm_resource_group.rg.id
}