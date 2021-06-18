diagnostic_event_hub_namespaces = {
  event_hub_namespace1 = {
    name               = "security_operation_logs"
    resource_group_key = "lb"
    sku                = "Standard"
    region             = "region1"
  }
}

diagnostics_destinations = {
  event_hub_namespaces = {
    central_logs_example = {
      event_hub_namespace_key = "event_hub_namespace1"
    }
  }
}

diagnostics_definition = {
  slb = {
    name = "operational_logs_and_metrics"

    categories = {
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 7],
      ]
    }
  }
}
