global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  test = {
    name = "rg1"
  }
}

# https://docs.microsoft.com/en-us/azure/storage/
storage_accounts = {
  sa1 = {
    name                     = "sa1"
    resource_group_key       = "test"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}



storage_containers = {
  sc1 = {
    name = "sc1"
    storage_account = {
      key = "sa1"
    }
    container_access_type = "private"
  }
}