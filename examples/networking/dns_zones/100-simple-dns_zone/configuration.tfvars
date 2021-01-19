global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
    region2 = "eastasia"
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

    contract = {
      name_first   = "John"
      name_last    = "Doe"
      email        = "test@contoso.com"
      phone        = "+65.12345678"
      organization = "Sandpit"
      job_title    = "Engineer"
      address1     = "Singapore"
      address2     = ""
      postal_code  = "018898"
      state        = "Singapore"
      city         = "Singapore"
      country      = "SG"
      auto_renew   = true
    }
  }
}