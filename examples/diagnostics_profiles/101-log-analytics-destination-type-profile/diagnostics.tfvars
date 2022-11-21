diagnostic_log_analytics = {
  central_logs_region1 = {
    name               = "logs"
    resource_group_key = "ops"
    region             = "region1"
  }
}

diagnostic_storage_accounts = {
  dsa1_region1 = {
    name                     = "diaglogsregion1"
    region                   = "region1"
    resource_group_key       = "ops"
    account_kind             = "StorageV2" # BlobStorage, Storage, StorageV2, BlockBlobStorage, FileStorage
    account_tier             = "Standard"  # Standard, Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    account_replication_type = "LRS"       # LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS
    tags                     = {}
    enable_system_msi        = true
  }
}
