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
    resource_group_key   = "webapp_simple"
    name                 = "webapp-simple"
    app_service_plan_key = "asp1"

    app_settings = {
      "WEBSITE_NODE_DEFAULT_VERSION" = "6.9.1"
    }

    settings = {
      enabled = true
    }
  }
}