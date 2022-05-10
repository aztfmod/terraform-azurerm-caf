# Defines the different destination for the different log profiles
# Different profiles to target different operational teams

diagnostics_destinations = {
  # Storage keys must reference the azure region name
  # For storage, reference "all_regions" and we will send the logs to the storage account
  # in the region of the deployment


  log_analytics = {
    central_logs = {
      #log_analytics_key              = "central_logs_region1"
      #log_analytics_destination_type = "Dedicated"
      log_analytics_resource_id = "/subscriptions/0-0-0-0-0/resourcegroups/eqej-rg-operations/providers/microsoft.operationalinsights/workspaces/eqej-log-logs"
    }
  }

  # use existing storage account
  storage = {
    central_storage = {
      australiaeast = { # region
        storage_account_resource_id = "/subscriptions/0-0-0-0-0/resourcegroups/eqej-rg-operations/providers/Microsoft.Storage/storageAccounts/imfd-log-storage"
      }
    }
  }
}