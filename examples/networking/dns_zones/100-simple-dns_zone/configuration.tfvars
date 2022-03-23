global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  dns_re1 = {
    name   = "sales-rg1"
    region = "region1"
  }
}

# IAM

managed_identities = {
  msi1 = {
    name               = "msi1"
    resource_group_key = "dns_re1"
  }
}

role_mapping = {
  built_in_role_mapping = {
    dns_zones = {
      dns_zone1 = {
        "DNS Zone Contributor" = {
          managed_identities = {
            keys = [
              "msi1"
            ]
          } //managed_identities
        }   //"DNS Zone Contributor"
      }     //dns_zone1
    }       //dns_zones
  }         //built_in_role_mapping
}