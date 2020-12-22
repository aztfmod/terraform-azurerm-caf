
storage_accounts = {
  level0 = {
    name                     = "level0"
    resource_group_key       = "rg1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
    containers = {
      tfstate = {
        name = "tfstate"
      }
    }
  }

}