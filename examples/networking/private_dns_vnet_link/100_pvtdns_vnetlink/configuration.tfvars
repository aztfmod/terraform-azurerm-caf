global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  private_dns_region1 = {
    name   = "private-dns-rg"
    region = "region1"
  }
}

private_dns_vnet_links = {
  vnet_pvtdns_link1 = {
    vnet_key = "vnet_test"
    #lz_key = "remote landing zone key for vnet"
    private_dns_zones = {
      dns_zone1 = {
        name = "dns1-lnk"
        key  = "dns1"
        #lz_key = "provide the landing zone key of private dns zone"
      }
      # dns_zone2 = {
      #   name     = "vnet1-link2"
      #   key = "dnszone2_key"
      # }
    }
  }
  # vnet_pvtdns_link2 = {
  #   vnet_key = "vnet_key2"
  #   private_dns_zones = {
  #     dns_zone1 = {
  #       name     = "vnet2-link1"
  #       key = "dnszone1_key"
  #     }
  #   }
  # }
}

vnets = {
  vnet_test = {
    resource_group_key = "private_dns_region1"
    vnet = {
      name          = "test-vnet"
      address_space = ["10.10.100.0/24"]
    }
    specialsubnets = {

    }
    subnets = {

    }
  }
}

private_dns = {
  dns1 = {
    name               = "test-dns.mysite.com"
    resource_group_key = "private_dns_region1"

    records = {
      a_records = {
        testa1 = {
          name    = "*"
          ttl     = 3600
          records = ["1.1.1.1", "2.2.2.2"]
        }
        testa2 = {
          name    = "@"
          ttl     = 3600
          records = ["1.1.1.1", "2.2.2.2"]
        }
      }

      txt_records = {
        testtxt1 = {
          name = "testtxt1"
          ttl  = 3600
          records = {
            r1 = {
              value = "testing txt 1"
            }
            r2 = {
              value = "testing txt 2"
            }
          }
        }
      }
    }
  }
}