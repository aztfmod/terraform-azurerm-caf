global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  inherit_tags = true
  tags = {
    example = "aadb2c/100-simple-aadb2c-directory"
  }
}

resource_groups = {
  rg1 = {
    name   = "example-aadb2c"
    region = "region1"
  }
}

aadb2c_directory = {
  dir1 = {
    resource_group_key      = "rg1"
    country_code            = "US"
    data_residency_location = "United States"
    display_name            = "example-b2c-tenant"
    # Domain requires .onmicrosoft.com suffix
    domain_name = "100simpleaadb2cdirectory.onmicrosoft.com"
    sku_name    = "PremiumP1"
  }
}