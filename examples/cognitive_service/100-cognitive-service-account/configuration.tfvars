global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
  random_length = 5
}

resource_groups = {
  test = {
    name = "test"
  }
}

cognitive_service_account = {
  test_account = {
    resource_group = {
      # accepts either id or key to get resource group id
      # id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/resourceGroup1"
      # lz_key = "examples"
      key = "test"
    }
    name     = "example"
    kind     = "Academic"
    sku_name = "S0"
    tags = {
      env = "test"
    }
  }
}

