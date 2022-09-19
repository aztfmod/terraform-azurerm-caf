global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  agw_region1 = {
    name   = "example-agw"
    region = "region1"
  }
}