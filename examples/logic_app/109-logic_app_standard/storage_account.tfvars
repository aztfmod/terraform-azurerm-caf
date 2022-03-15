storage_accounts = {
  logic_app_sa = {
    name                     = "logicappsa1"
    resource_group_key       = "logic_app_rg"
    region                   = "region1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}