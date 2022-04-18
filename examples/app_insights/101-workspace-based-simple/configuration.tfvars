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


azurerm_application_insights = {
  webapp = {
    name               = "example-appinsights-web"
    resource_group_key = "rg1"
    application_type   = "web"
    log_analytics_workspace = {
      # lz_key = ""
      key = "law1"
    }
  }
}