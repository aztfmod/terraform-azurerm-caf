diagnostic_storage_accounts = {
  dsa1 = {
    name                     = "dsa1dev"
    resource_group_key       = "test"
    region                   = "region1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    tags = {
      environment = "dev"
      team        = "IT"
    }
    enable_system_msi = true
  }
}

diagnostic_log_analytics = {
  central_logs_region1 = {
    name               = "logs"
    resource_group_key = "test"
    region             = "region1"
    tags = {
      environment = "dev"
      team        = "IT"
    }
  }
}

diagnostics_definition = {
  storage = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        # ["StorageRead", true, false, 14],
        # ["StorageWrite", true, false, 14],
        # ["StorageDelete", true, false, 14]
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["Transaction", true, false, 7],
      ]
    }
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
        storage_account_key = "dsa1"
      }
    }
  }
}
