global_settings = {
  default_region = "region1"
  prefix         = null
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  hub_re1 = {
    name   = "vnet-hub-re1"
    region = "region1"
  }
}

virtual_wans = {
  vwan_re1 = {
    resource_group_key = "hub_re1"
    name               = "contosovWAN-re1"
    region             = "region1"

    hubs = {
      hub_re1 = {
        hub_name           = "hub-re1"
        region             = "region1"
        hub_address_prefix = "10.0.3.0/24"
        deploy_firewall    = false
        deploy_p2s         = false
        p2s_config         = {}
        deploy_s2s         = false
        s2s_config         = {}
        deploy_er          = false
        vnet_connections = {
          con1 = {
            name     = "vnet1-con1"
            vnet_key = "vnet1_region1"
            #lz_key =
            #to cather for external object
            #vnet_id = "Azure_Resource_ID"
          }
          con2 = {
            name     = "vnet2-con1"
            vnet_key = "vnet2_region1"
            #lz_key =
            #to cather for external object
            #vnet_id = "Azure_Resource_ID"
          }
        }
        route_tables = {
          routetable1 = {
            name   = "example-vhubroutetable1"
            labels = ["label1"]
            routes = {
              r1 = {
                name              = "example-route1"
                destinations_type = "CIDR"
                destinations      = ["10.0.0.0/16"]
                next_hop_key      = "con1"
                #to cather for external object
                #next_hop_id       = "Azure_Resource_ID"
              }
            }
          }
          routetable2 = {
            name   = "example-vhubroutetable2"
            labels = ["label2"]
            r2 = {
              name              = "example-route2"
              destinations_type = "CIDR"
              destinations      = ["1.0.0.0/16"]
              next_hop_key      = "con2"
              #to cather for external object
              #next_hop_id       = "Azure_Resource_ID"
            }
          }
        }
      }
    }

  }
}

vnets = {
  vnet1_region1 = {
    resource_group_key = "hub_re1"
    vnet = {
      name          = "vwan_demo1"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      example = {
        name = "vwan_demo"
        cidr = ["10.100.100.0/29"]
      }
    }

  }
  vnet2_region1 = {
    resource_group_key = "hub_re1"
    vnet = {
      name          = "vwan_demo2"
      address_space = ["10.100.200.0/24"]
    }
    specialsubnets = {}
    subnets = {
      example = {
        name = "vwan_demo"
        cidr = ["10.100.200.0/29"]
      }
    }

  }
}