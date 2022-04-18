global_settings = {
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  rg1 = {
    name = "example-appinsight-rg"
  }
}

log_analytics = {
  law1 = {
    name               = "appinsightexamplelaw"
    resource_group_key = "rg1"
  }
}

storage_accounts = {
  sa1 = {
    name                     = "sa1dev"
    resource_group_key       = "rg1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}
log_analytics_storage_insights = {
  lasi1 = {
    name                 = "lasi1"
    blob_container_names = ["wad-iis-logfiles"]
    resource_group = {
      key = "rg1"
    }
    log_analytics = {
      key = "law1"
    }
    storage_account = {
      key = "sa1"
    }
  }
}