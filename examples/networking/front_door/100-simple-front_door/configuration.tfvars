global_settings = {
  random_length  = "5"
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  inherit_tags = true
}

resource_groups = {
  front_door = {
    name = "front-door-rg"
  }
}

