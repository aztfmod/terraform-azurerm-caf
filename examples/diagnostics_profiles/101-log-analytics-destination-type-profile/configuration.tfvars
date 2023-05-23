global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  inherit_tags = true

  tags = {
    example = "diagnostics_profiles/101-log-analytics-destination-type-profile"
  }
}

resource_groups = {
  ops = {
    name = "operations"
  }
}
