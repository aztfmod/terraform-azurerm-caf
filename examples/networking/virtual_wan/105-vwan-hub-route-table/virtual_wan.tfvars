global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
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
  }
}

virtual_hubs = {
  hub_re1 = {
    virtual_wan = {
      # lz_key = "" # for remote deployment
      key = "vwan_re1"
    }

    resource_group = {
      # lz_key = "" # for remote deployment
      key = "hub_re1"
    }

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

# "example-vhubroutetable1" is the Static Route Gets assigned to directing Internet traffic to Secured VHUB Azure Firewall ResourceID
virtual_hub_route_tables = {
  routetable1 = {
    name = "example-vhubroutetable1"

    virtual_hub = {
      key = "hub_re1"
    }

    labels = ["label1", "default"]
    routes = {
      egress_internet = {
        name              = "egress-internet"
        destinations_type = "CIDR"
        destinations      = ["0.0.0.0/0"]

        #   # Either next_hop or next_hop_id can be used
        #   # When using next_hop, the azurerm_firewalls or virtual_hub_connection must be deployed in a different landingzone. This cannot be tested in the standalone module.
        #   # Will be covered in the landingzone starter production configuration in future releases.
        next_hop = {
          #  lz_key = "secazfw1" # Remote Landing Zone Key from where Azure Firewall Key needs to be retrieved
          resource_type = "azurerm_firewalls" # Only supported value in case of "Secured Virtual HUB" where you need to route Internet Egress from Secured vHUB Firewall.
          #    resource_type = "virtual_hub_connection"  # Only supported value in case mapping route at VNET Connection Level
          key = "egress-fw" # Azure Firewall Key sitting in the Secured Virtual Hub
        }
        #to cather for external object
        #next_hop_id       = "Azure_Resource_ID"
      }
    }
  }
  routetable2 = {
    name = "example-vhubroutetable2"

    virtual_hub = {
      key = "hub_re1"
    }

    labels = ["label2"]
  }
}

virtual_hub_connections = {

  # Establish the peering with Virtual Hubs

  con1 = {
    name                      = "vnet1-con1"
    internet_security_enabled = true

    virtual_hub = {
      key = "hub_re1"
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
          egress_internet = {
            name = "egress-internet"
            address_prefixes = [
              "0.0.0.0/0"
            ]


            # Either next_hop or next_hop_ip_address can be used
            next_hop = {
              # lz_key = "" #
              key             = "egress-fw"
              interface_index = 0 # Required.
            }

            # next_hop_ip_address = "192.34.23.11"
          }
        }

      }
    }
  }

  con2 = {
    name                      = "vnet2-con2"
    internet_security_enabled = true

    virtual_hub = {
      key = "hub_re1"
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

# Following Code is only use if you want to deploy Azure Firewall in SPOKE VNET (For Non Secure Virtual Hub)
# This Deployment is also called NVA in SPOKE VNET
azurerm_firewalls = {
  egress-fw = {
    name               = "egress-firewall"
    sku_name           = "AZFW_Hub"
    sku_tier           = "Standard"
    resource_group_key = "hub_re1"
    vnet_key           = "vnet1_region1"
    virtual_hub = {
      hub_re1 = {
        virtual_wan_key = "vwan_re1"
        virtual_hub_key = "hub_re1"
        #virtual_hub_id = "Azure_resource_id"
        #lz_key = "lz_key"
        public_ip_count = 1
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
    specialsubnets = {
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" # must be named AzureFirewallSubnet
        cidr = ["10.100.100.128/25"]
      }
    }
    subnets = {
      example = {
        name = "vwan_demo"
        cidr = ["10.100.100.0/25"]
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