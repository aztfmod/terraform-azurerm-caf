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

    custom_domains = {
      # root domain txt token
      # also needs an ALIAS record set (see: https://docs.microsoft.com/en-us/azure/static-web-apps/custom-domain-external)
      txt_domain = {
        domain_name     = "mystaticsite.com"
        validation_type = "dns-txt-token"
      }
      cname_subdomain = {
        # note: A CNAME cannot be placed at the root domain level
        # so you cannot use a CNAME entry for mystaticsite.com
        domain_name     = "subdomain.mystaticsite.com"
        validation_type = "cname-delegation"
      }
      www_subdomain = {
        domain_name     = "www.mystaticsite.com"
        validation_type = "cname-delegation"
      }
    }
  }
}
