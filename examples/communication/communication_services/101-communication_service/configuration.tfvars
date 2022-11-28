global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiacentral"
  }
}

resource_groups = {
  rg1 = {
    name = "rg1"
  }
}

communication_services = {
  cs1 = {
    name               = "test-acs1-re1"
    resource_group_key = "rg1"
    data_location      = "United States"
  }
  cs2 = {
    name               = "test-acs2-re2"
    resource_group_key = "rg1"
    data_location      = "United States"
  }
}