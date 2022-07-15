## resources deployment
diagnostic_log_analytics = {
  central_logs_region1 = {
    region             = "region1"
    name               = "logs"
    resource_group_key = "vnet_hub_re1"

  }
}

diagnostic_storage_accounts = {
  # Stores diagnostic logging for region1
  diaglogs_region1 = {
    name                     = "diaglogsre1"
    region                   = "region1"
    resource_group_key       = "vnet_hub_re1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Hot"
  }
  diaglogs_region2 = {
    name                     = "diaglogsre2"
    region                   = "region2"
    resource_group_key       = "vnet_hub_re1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Hot"
  }
}

## destinations definition
diagnostics_destinations = {
  log_analytics = {
    central_logs = {
      log_analytics_key              = "central_logs_region1"
      log_analytics_destination_type = "Dedicated"
    }
  }

  storage = {
    all_regions = {
      australiaeast = {
        storage_account_key = "diaglogs_region1"
      }
      australiacentral = {
        storage_account_key = "diaglogs_region2"
      }
    }
  }
}