
diagnostic_storage_accounts = {
  diagnostics_region1 = {
    name                     = "diagrg1"
    resource_group_key       = "front_door"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
}