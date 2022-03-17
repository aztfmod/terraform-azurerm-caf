global_settings = {
  regions = {
    region1 = "australiaeast"
    region2 = "australiacentral"
  }
}
resource_groups = {
  rg1 = {
    name = "rg1"
  }
}

purview_accounts = {
  pva1 = {
    name   = "pva1"
    region = "region1"
    resource_group = {
      key = "rg1"
    }
  }
}