global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westeurope"
  }
}

resource_groups = {
  rg1 = {
    name   = "example-agw"
    region = "region1"
  }
}

api_management = {
  example_apim = {
    name               = "example-apim"
    resource_group_key = "rg1"
    publisher_name     = "My Company"
    publisher_email    = "company@terraform.io"
    sku_name           = "Consumption_0"
  }
}

api_management_subscription = {
  example_sub = {
    api_management = {
      key = "example_apim"
    }
    resource_group = {
      key = "rg1"
    }
    display_name = "Example Subscription"
    state        = "active"
  }
}
