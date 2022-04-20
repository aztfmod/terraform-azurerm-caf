global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  webapp_simple = {
    name   = "webapp-simple"
    region = "region1"
  }
}

azurerm_application_insights = {
  app_insights1 = {
    name               = "appinsights-simple"
    resource_group_key = "webapp_simple"
    application_type   = "web"
  }
}

# By default asp1 will inherit from the resource group location
app_service_plans = {
  asp1 = {
    resource_group_key = "webapp_simple"
    name               = "asp-simple"

    sku = {
      tier = "Standard"
      size = "S1"
    }
  }
}

app_services = {
  webapp1 = {
    resource_group_key      = "webapp_simple"
    name                    = "webapp-simple"
    app_service_plan_key    = "asp1"
    application_insight_key = "app_insights1"

    settings = {
      enabled = true
    }
  }
}