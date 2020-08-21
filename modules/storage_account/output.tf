output id {
  value     = azurerm_storage_account.stg.id
  sensitive = true
}

output name {
  value     = azurerm_storage_account.stg.name
  sensitive = true
}

output location {
  value     = var.location
  sensitive = true
}

output resource_group_name {
  value     = var.resource_group_name
  sensitive = true
}

output primary_blob_endpoint {
  value     = azurerm_storage_account.stg.primary_blob_endpoint
  sensitive = true
}