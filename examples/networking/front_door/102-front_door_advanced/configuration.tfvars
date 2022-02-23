global_settings = {
  random_length  = "5"
  default_region = "region1"
  regions = {
    region1 = "eastus2"
  }
}

resource_groups = {
  front_door = {
    name = "front-door-rg"
  }
}
