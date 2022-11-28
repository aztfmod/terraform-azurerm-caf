
# Event hub diagnostics
diagnostic_event_hub_namespaces = {

  central_logs_region1 = {
    name               = "centrallogs"
    resource_group_key = "ops"
    sku                = "Standard"
    region             = "region1"

    event_hubs = {
      hub1 = {
        name              = "eventhub1"
        partition_count   = 4
        message_retention = 7
      }
    }

  }

  namespace2 = {
    name               = "logs"
    resource_group_key = "ops"
    sku                = "Standard"
    region             = "region1"

    # eventhub namespace cannot reference itself, thus a secondary is used to send diagnostics logs to central eventhub namespace
    diagnostic_profiles = {
      central_logs_region1 = {
        definition_key   = "event_hub_namespace"
        destination_type = "event_hub"
        destination_key  = "central_logs"
        event_hub_key    = "hub1" # only for event_hub_namespaces
      }
    }
  }


}


