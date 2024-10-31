global_settings = {
  default_region = "region1"
  regions = {
    region1 = "francecentral"
  }
}

resource_groups = {
  rg1 = {
    name   = "rg1"
    region = "region1"
  }
}

storage_accounts = {
  sa1 = {
    name                     = "5116e929eed5"
    resource_group_key       = "rg1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}

management_locks = {
  resource_groups = {
    rg1 = {
      name  = "rg-lock"
      key   = "rg1"
      level = "ReadOnly"
    }
  }
  storage_accounts = {
    sa1 = {
      name  = "sa-lock"
      key   = "sa1"
      level = "CanNotDelete"
    }
  }
}
