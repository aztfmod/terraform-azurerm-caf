global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  test = {
    name = "rg-maps-test"
  }
}

maps_account = {
  map1 = {
    name                      = "map1"
    resource_group_key        = "test"
    sku_name                  = "S0"
  }
}
