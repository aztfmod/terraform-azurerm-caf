output blobs {
  value = module.blob
}


output name {
  value = azurerm_storage_container.stg.name
}