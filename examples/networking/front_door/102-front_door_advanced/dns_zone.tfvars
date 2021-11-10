dns_zones = {
  dns_zone1 = {
    name               = "" // When left empty generate a random domain name. Mainly used in CI
    region             = "region1"
    resource_group_key = "front_door"

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