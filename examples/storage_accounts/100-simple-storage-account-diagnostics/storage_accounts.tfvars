# https://docs.microsoft.com/en-us/azure/storage/
storage_accounts = {
  sa1 = {
    name                     = "sa1dev"
    resource_group_key       = "test"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    tags = {
      environment = "dev"
      team        = "IT"
    }
    containers = {
      dev = {
        name = "random"
      }
    }

    enable_system_msi = true

    diagnostic_profiles = {
      central_logs_region1 = {
        name             = "log_and_metrics_log_analytics"
        definition_key   = "storage"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
      dsa1 = {
        name             = "log_and_metrics_log_storage"
        definition_key   = "storage"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
    }

  }
}
