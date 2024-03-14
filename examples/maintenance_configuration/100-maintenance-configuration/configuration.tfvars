global_settings = {
  default_region = "region1"
  regions = {
    region1 = "northeurope"
  }
}

resource_groups = {
  rg1 = {
    name   = "rsg_umc"
    region = "region1"
  }
}

maintenance_configuration = {
  mc_re1 = {
    name               = "example-mc"
    region             = "region1"
    resource_group_key = "rg1"
    scope              = "Host"
    # tags               = {} # optional
  }
}



