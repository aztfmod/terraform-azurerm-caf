
resource_groups = {
  asp = {
    name = "api-rg-pro"
  }
}

# By default asp1 will inherit from the resource group location
app_service_plans = {
  asp1 = {
    resource_group_key = "asp"
    name               = "api-appserviceplan-elastic"

    kind     = "elastic"
    reserved = true

    sku = {
      tier     = "ElasticPremium"
      size     = "EP1"
      capacity = 1
    }
  }
}