global_settings = {
  regions = {
    region1 = "uksouth"
  }
}

resource_groups = {
  rg1 = {
    name = "example-appinsight-rg"
  }
}

diagnostic_log_analytics = {
  central_logs_region1 = {
    region             = "region1"
    name               = "central_logs"
    resource_group_key = "rg1"
  }
}

diagnostics_destinations = {
  log_analytics = {
    central_logs = {
      log_analytics_key              = "central_logs_region1"
      log_analytics_destination_type = "Dedicated"
    }
  }
}

azurerm_application_insights = {
  webapp = {
    name                                = "example-appinsights-web"
    resource_group_key                  = "rg1"
    application_type                    = "web"
    log_analytics_workspace_destination = "central_logs"
  }
}
