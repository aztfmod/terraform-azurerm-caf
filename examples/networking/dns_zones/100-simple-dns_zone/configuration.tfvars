global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  dns_re1 = {
    name   = "sales-rg1"
    region = "region1"
  }
}

dns_zones = {
  dns_zone1 = {
    name               = "" // Set as empty for CI. this will creation a random_domain_name.com
    region             = "region1"
    resource_group_key = "dns_re1"
  }
}  