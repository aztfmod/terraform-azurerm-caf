
global_settings = {
  regions = {
    region1 = "australiaeast"
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
    name                                  = "tf-test-appinsights-web"
    resource_group_key                    = "rg1"
    application_type                      = "web"
    daily_data_cap_in_gb                  = 100
    daily_data_cap_notifications_disabled = false
    retention_in_days                     = 180
    sampling_percentage                   = 50
    disable_ip_masking                    = true
  }
  ios = {
    name               = "tf-test-appinsights-ios"
    resource_group_key = "rg1"
    application_type   = "ios"
  }
}