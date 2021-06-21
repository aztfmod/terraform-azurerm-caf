global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
  random_length = 5
}

resource_groups = {
  example = {
    name = "example"
  }
}

monitor_action_groups = {
  example = {
    action_group_name  = "example-ag-name"
    resource_group_key = "example"
    shortname          = "example"
  }
}