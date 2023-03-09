global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westeurope"
  }
}

resource_groups = {
  rg1 = {
    name   = "staticsite"
    region = "region1"
  }
}

static_sites = {
  s1 = {
    name               = "staticsite"
    resource_group_key = "rg1"
    region             = "region1"

    sku_tier = "Standard"
    sku_size = "Standard"
  }
}
