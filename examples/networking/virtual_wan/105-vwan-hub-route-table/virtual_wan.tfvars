global_settings = {
  default_region = "region1"
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
      }
    }
  }
}


virtual_hub_route_tables = {
  routetable1 = {
    name = "example-vhubroutetable1"

    virtual_wan_key = "vwan_re1"
    virtual_hub_key = "hub_re1"

    labels = ["label1"]
    routes = {
      # r1 = {
      #   name              = "example-route1"
      #   destinations_type = "CIDR"
      #   destinations      = ["10.0.0.0/16"]
      #   next_hop = {
      #     # lz_key if the connection is in a different deployment
      #     resource_type = "azurerm_firewall"
      #     resource_key  = "con2"
      #   }
      #   #to cather for external object
      #   #next_hop_id       = "Azure_Resource_ID"
      # }
    }
  }
  routetable2 = {
    name = "example-vhubroutetable2"

    virtual_wan_key = "vwan_re1"
    virtual_hub_key = "hub_re1"

    labels = ["label2"]
  }
}

virtual_hub_connections = {

  # Establish the peering with Virtual Hubs

  con1 = {
    name                      = "vnet1-con1"
    internet_security_enabled = true

    vhub = {
      virtual_wan_key = "vwan_re1"
      virtual_hub_key = "hub_re1"
    }

    vnet = {
      # If the virtual network is stored in another another landing zone, use the following attributes to refer the state file:
      vnet_key = "vnet1_region1"
    }

    routing = {
      route1 = {
        virtual_hub_route_table_key = "routetable1"

        propagated_route_table = {
          virtual_hub_route_table_keys = [
            "routetable1"
          ]
          # ids = [
          #   "/subscriptions/{subscriptionId}/resourceGroups/testRG/providers/Microsoft.Network/virtualHubs/westushub/hubRouteTables/defaultRouteTable"
          # ]
          labels = ["test", "test1"]
        }

        static_vnet_route = {
          # crm = {
          #   name = "crm"
          #   address_prefixes  = [
          #     "10.12.13.0/21"
          #   ]
          #   next_hop_ip_address = "192.34.23.11"
          # }
        }

      }
    }
  }

  con2 = {
    name                      = "vnet2-con2"
    internet_security_enabled = true

    vhub = {
      virtual_wan_key = "vwan_re1"
      virtual_hub_key = "hub_re1"
    }

    vnet = {
      # If the virtual network is stored in another another landing zone, use the following attributes to refer the state file:
      vnet_key = "vnet2_region1"
    }

    routing = {
      route1 = {
        virtual_hub_route_table_key = "routetable2"

        propagated_route_table = {
          # lz_keys = ""
          virtual_hub_route_table_keys = [
            "routetable2"
          ]
          # ids = [
          #   "/subscriptions/{subscriptionId}/resourceGroups/testRG/providers/Microsoft.Network/virtualHubs/westushub/hubRouteTables/defaultRouteTable"
          # ]
          labels = [
            "test2"
          ]
        }

        static_vnet_route = {
          # crm = {
          #   name = "crm"
          #   address_prefixes  = [
          #     "10.12.13.0/21"
          #   ]
          #   next_hop_ip_address = "192.34.23.11"
          # }
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