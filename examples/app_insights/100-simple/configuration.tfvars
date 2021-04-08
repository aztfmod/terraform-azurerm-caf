
global_settings = {
  regions = {
    region1 = "southeastasia"
  }
}


resource_groups = {
  rg1 = {
    name   = "examples-app-insights"
    region = "region1"
  }
}

azurerm_application_insights = {
  webapp = {
    name               = "tf-test-appinsights-web"
    resource_group_key = "rg1"
    application_type   = "web"
  }
}