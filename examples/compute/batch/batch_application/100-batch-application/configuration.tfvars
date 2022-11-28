global_settings = {
  default_region = "region1"
  environment    = "test"
  regions = {
    region1 = "eastus"
    region2 = "centralus"
    region3 = "westeurope"
  }
}

resource_groups = {
  batch_region1 = {
    name = "batch"
  }
}

batch_accounts = {
  batch1 = {
    name                = "batch"
    resource_group_key  = "batch_region1"
    storage_account_key = "batch_region1"
  }
}

batch_applications = {
  application1 = {
    name              = "batch"
    batch_account_key = "batch1"
  }
}

storage_accounts = {
  batch_region1 = {
    name                     = "batch"
    resource_group_key       = "batch_region1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}
