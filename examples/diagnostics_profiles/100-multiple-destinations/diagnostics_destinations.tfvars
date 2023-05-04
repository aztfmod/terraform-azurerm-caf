diagnostics_destinations = {
  event_hub_namespaces = {
    central_logs = {
      event_hub_namespace_key = "central_logs_region1"
    }
  }

  log_analytics = {
    central_logs = {
      log_analytics_key              = "central_logs_region1"
      log_analytics_destination_type = "Dedicated"
    }
  }
  storage = {
    central_logs = {
      australiaeast = {
        storage_account_key = "dsa1_region1"
      }
    }
  }
}
