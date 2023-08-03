global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  inherit_tags = true
  tags = {
    example = "/examples/app_gateway/102-waf-policy"
  }
}

resource_groups = {
  agw_waf = {
    name = "agw_waf-rg"
  }
}



