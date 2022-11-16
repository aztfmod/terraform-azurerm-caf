
global_settings = {
  regions = {
    region1 = "westeurope"
  }
}


resource_groups = {
  asp_region1 = {
    name   = "api-rg-pro"
    region = "region1"
  }
}

# By default asp1 will inherit from the resource group location
app_service_plans = {
  asp1 = {
    resource_group_key = "asp_region1"
    name               = "api-appserviceplan-pro-std-windows"

    sku = {
      tier = "Standard"
      size = "S1"
    }
  }
}