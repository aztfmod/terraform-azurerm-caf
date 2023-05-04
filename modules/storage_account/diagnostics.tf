module "diagnostics" {
  source = "../diagnostics"
  count  = var.diagnostic_profiles == {} ? 0 : 1

  resource_id       = azurerm_storage_account.stg.id
  resource_location = azurerm_storage_account.stg.location
  diagnostics       = var.diagnostics
  profiles          = try(var.diagnostic_profiles, {})
}

module "diagnostics_blob" {
  source = "../diagnostics"
  count  = var.diagnostic_profiles_blob == {} ? 0 : 1

  resource_id       = "${azurerm_storage_account.stg.id}/blobServices/default/"
  resource_location = azurerm_storage_account.stg.location
  diagnostics       = var.diagnostics
  profiles          = try(var.diagnostic_profiles_blob, {})
}


module "diagnostics_queue" {
  source = "../diagnostics"
  count  = var.diagnostic_profiles_queue == {} ? 0 : 1

  resource_id       = "${azurerm_storage_account.stg.id}/queueServices/default/"
  resource_location = azurerm_storage_account.stg.location
  diagnostics       = var.diagnostics
  profiles          = try(var.diagnostic_profiles_queue, {})
}


module "diagnostics_table" {
  source = "../diagnostics"
  count  = var.diagnostic_profiles_table == {} ? 0 : 1

  resource_id       = "${azurerm_storage_account.stg.id}/tableServices/default/"
  resource_location = azurerm_storage_account.stg.location
  diagnostics       = var.diagnostics
  profiles          = try(var.diagnostic_profiles_table, {})
}


module "diagnostics_file" {
  source = "../diagnostics"
  count  = var.diagnostic_profiles_file == {} ? 0 : 1

  resource_id       = "${azurerm_storage_account.stg.id}/fileServices/default/"
  resource_location = azurerm_storage_account.stg.location
  diagnostics       = var.diagnostics
  profiles          = try(var.diagnostic_profiles_file, {})
}
