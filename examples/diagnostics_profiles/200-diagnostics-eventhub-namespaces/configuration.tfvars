global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  inherit_tags = true

  tags = {
    example = "diagnostics_profiles/200-diagnostics-eventhub-namespaces"
  }
}


resource_groups = {
  ops = {
    name = "operations"
  }
}
