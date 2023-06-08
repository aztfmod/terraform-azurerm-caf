global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  inherit_tags = true

  tags = {
    example = "diagnostics_profiles/202-reuse-existing-log-analytics"
  }
}


resource_groups = {
  ops = {
    name = "operations"
  }
}
