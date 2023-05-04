global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  rg1 = {
    name   = "example-adt"
    region = "region1"
  }
}


digital_twins_instances = {
  adt1 = {
    name               = "example-adt"
    region             = "region1"
    resource_group_key = "rg1"

  }
}