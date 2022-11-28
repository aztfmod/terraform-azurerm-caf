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

    vnet_links = {
      link_test = {
        name     = "test-vnet-link"
        vnet_key = "vnet_test"
      }
      # link_hub = {
      #   name = "hub-vnet-link"
      #   remote_tfstate = {
      #     tfstate_key = "networking_hub"
      #     lz_key      = "networking_hub"
      #     output_key  = "vnets"
      #     vnet_key    = "hub_rg1"
      #   }
      # }
    }
  }
}