global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  inherit_tags = true
  tags = {
    example = "examples/networking/private_dns_vnet_link/100_pvtdns_vnetlink"
  }
}

resource_groups = {
  private_dns_region1 = {
    name   = "private-dns-rg"
    region = "region1"
    tags = {
      rg_key = "private_dns_region1"
    }
  }
}

private_dns_vnet_links = {
  vnet_pvtdns_link1 = {
    #
    # 
    #
    version  = "v1"
    vnet_key = "vnet_test"
    tags = {
      private_dns_vnet_links = "vnet_pvtdns_link1"
    }
    #lz_key = "remote landing zone key for vnet"
    private_dns_zones = {
      dns_zone1 = {
        name = "dns1-lnk"
        key  = "dns1"
        #lz_key = "provide the landing zone key of private dns zone"
        # dns_parent_id = "resource id of the private dns zone"
      }
    }
  }
  vnet_pvtdns_link2 = {
    vnet_key = "vnet_test"
    # lz_key = ""
    private_dns_zones = {
      dns_zone2 = {
        name = "vnet2-link1"
        key  = "dns2"
      }
    }
  }
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

    tags = {
      private_dns_key = "dns1"
    }

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
  dns2 = {
    name               = "test2-dns.mysite.com"
    resource_group_key = "private_dns_region1"

    tags = {
      private_dns_key = "dns2"
    }
  }
}