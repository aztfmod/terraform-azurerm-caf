communication_services = {
  cs1 = {
    name                = "test-acs1-re1"
    resource_group_key  = "rg_region1"
    data_location       = "United States"

    diagnostic_profiles = {
      diagnostics_storage_account = {
        name             = "diagnostics-storageaccount"
        definition_key   = "communication_services"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
      diagnostics_log_analytic = {
        name             = "diagnostics-loganalytics"
        definition_key   = "communication_services"
        destination_type = "log_analytics"
        destination_key  = "eus_logs"
      }
      operationsevh = {
        name             = "diagnostics-eventhub"
        definition_key   = "communication_services"
        destination_type = "event_hub"
        destination_key  = "eus_evh"
      }
    }
  }
  cs2 = {
    name                = "test-acs2-re2"
    resource_group_key  = "rg_region1"
    data_location       = "United States"
  }
}