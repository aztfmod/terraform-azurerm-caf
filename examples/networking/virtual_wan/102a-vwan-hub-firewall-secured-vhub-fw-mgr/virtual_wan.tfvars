# Best Practice To deploy Secured Virtual HUB (vHUB), End to End Process should follow sequence like this;
# 1. vWAN deployment (Ideally First Time Deployment only because Generally vWAN is single deployment per Over Enterprise Landing Zone)
# 2. vHUB deployment (Subsequent vHUB deployment can start process from step 2)
# 3. Firewall Policy Deployment (It can be idependent of vHUB/vWAN deployment also)
# 4. Deploy Azure Firewall into the virtual hub (Thus, coverting virtual HUB into Secured Virtual HUB)
# 5. Route Table Deployment (If using Internet Egress Control via Secured vHUB Firewall,
# Then it should deployed in sequence after Secured vHUB deployment)


global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

# Seperate Resource Group where Azure Firewall will be deployed into
resource_groups = {
  contoso_global_wan = {
    name   = "contoso-connectivity-global-wan"
    region = "region1"
  }
  firewall_policy = {
    name = "Central_FirewallManager"
  }
  vnets = {
    name = "contoso-connectivity-vnets"
  }
}


virtual_wans = {
  "contoso_global_wan" = {
    resource_group_key = "contoso_global_wan"
    name               = "contosov-vwan"
    region             = "region1"
  }
}


virtual_hubs = {
  hub1 = {
    virtual_wan = {
      # lz_key = "connectivity_virtual_wan"
      key = "contoso_global_wan"
    }

    resource_group = {
      # lz_key = "connectivity_virtual_wan"
      key = "contoso_global_wan"
    }

    hub_name           = "hub1"
    region             = "region1"
    hub_address_prefix = "192.168.14.0/24"
    deploy_p2s         = false
    p2s_config         = {}
    deploy_s2s         = false
    s2s_config         = {}
    deploy_er          = false
  }
}

azurerm_firewall_policies = {
  policy1 = {
    name = "firewall_policy"
    # resource_group = {
    #   key = "firewall_policy"
    # }
    resource_group_key = "firewall_policy"
    sku                = "Standard"
    region             = "region1"
    # Premium Policy Features
    #   dns = {
    #     proxy_enabled = "true"
    #   }
    #   threat_intelligence_mode = "Alert"
    #   threat_intelligence_allowlist = {
    #     fqdns = ["microsoft.com", "demo.com"]
  }
}

azurerm_firewall_policy_rule_collection_groups = {
  group1 = {
    #firewall_policy_id = "Azure Resource ID"
    firewall_policy_key = "policy1"
    name                = "example-fwpolicy-rcg"
    priority            = 500

    application_rule_collections = {
      rule1 = {
        name     = "app_rule_collection1"
        priority = 500
        action   = "Deny"
        rules = {
          rule1 = {
            name = "app_rule_collection1_rule1"
            protocols = {
              1 = {
                type = "Http"
                port = 80
              }
              2 = {
                type = "Https"
                port = 443
              }
            }
            source_addresses  = ["172.10.0.0/16"]
            destination_fqdns = ["*.linkedin.com", "*.facebook.com"]
          }
        }
      }
    }

    network_rule_collections = {
      group1 = {
        name     = "network_rule_collection1"
        priority = 400
        action   = "Deny"
        rules = {
          rule1 = {
            name                  = "network_rule_collection1_rule1"
            protocols             = ["TCP", "UDP"]
            source_addresses      = ["172.10.0.0/16"]
            destination_addresses = ["192.168.1.1", "192.168.1.2"]
            destination_ports     = ["80", "1000-2000"]
          }
        }
      }
    }

    # nat_rule_collections = {
    #   group1 = {
    #     name     = "nat_rule_collection1"
    #     priority = 300
    #     action   = "Dnat"
    #     rules = {
    #       rule1 = {
    #         name                = "nat_rule_collection1_rule1"
    #         protocols           = ["TCP"]
    #         source_addresses    = ["*"]
    #         destination_address = "192.168.1.1"
    #         # destination_address_public_ip_key = "pip_key"
    #         destination_ports   = ["80", "1000-2000"]
    #         translated_address  = "192.168.0.1"
    #         translated_port     = "8080"
    #       }
    #     }
    #   }
    # }
  }

}

# # Sample Landing Zone TFVARs for Secured vHUB Coversion , where at Stpe 4, Firewall Call Remote TFState of vHUB and Firewall Policy Deployment
# landingzone = {
#   backend_type        = "azurerm"
#   # Mapping of vHUB which needs to be converted into Secured vHUB
#   global_settings_key = "connectivity_virtual_hub1"
#   level               = "level2"
#   key                 = "secazfw1"
#   tfstates = {
#   # Mapping of Remote TF State File for vHUB which needs to be converted into Secured vHUB
#     connectivity_virtual_hub1 = {
#       level   = "current"
#       tfstate = "connectivity_virtual_hub1.tfstate"
#     }
#   # Mapping of Remote TF State File for Firewall Policy which needs to be deployed into Secured vHUB Azure Firewall
#     firewallpolicy = {
#       level   = "current"
#       tfstate = "firewallpolicy.tfstate"
#     }
#   }
# }

# Azure Firewall Deployement into vHUB to covert into secured vHUB
azurerm_firewalls = {
  firewall1 = {
    name                = "test-firewall"
    sku_name            = "AZFW_Hub"
    sku_tier            = "Standard" # Standard, Premium
    firewall_policy_key = "policy1"  # Ensure Policy is of same SKU as Firewall
    region              = "region1"
    # resource_group_key  = "firewall1"
    resource_group = {
      # lz_key = "firewallpolicy" # In case key to call out from Remote TState
      key = "firewall_policy"
    }
    virtual_hub = {
      hub1 = {
        key = "hub1"
        # lz_key = "connectivity_virtual_hub1" # In case key to call out from Remote TState
        public_ip_count = 1
      }
    }
  }
}

virtual_hub_route_table_routes = {
  all_traffic = {
    route_table = {
      name = "defaultRouteTable"
    }
    virtual_hub = {
      key = "hub1"
    }
    # to route to the secure firewall name must be aither 'all_traffic', 'private_traffic', 'public_traffic'
    name              = "all_traffic"
    destinations_type = "CIDR"

    # Configure virtual hub security. Updates will apply globally to all connections.
    #
    # If your organization uses public IP ranges in Virtual Networks and Branch Offices, you will need to specify those IP prefixes explicitly. 
    # The public IP prefixes can be specified individually or as aggregates.
    #
    # Include RFC 1918 prefixes in the private traffic range.
    #
    destinations  = ["0.0.0.0/0", "10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
    next_hop_type = "ResourceId"
    next_hop = {
      # lz_key = ""
      resource_type = "azurerm_firewall"
      key           = "firewall1"
      # or
      # id = ""
    }
  }
  # public_traffic = {
  #   public_traffic = {
  #     name = "defaultRouteTable"
  #   }
  #   virtual_hub = {
  #     key = "hub1"
  #   }
  #   # to route to the secure firewall name must be aither 'all_traffic', 'private_traffic', 'public_traffic'
  #   name = "public_traffic"
  #   destinations_type = "CIDR"
  #   destinations = ["0.0.0.0/0"]
  #   next_hop_type = "ResourceId"
  #   next_hop = {
  #     # lz_key = ""
  #     resource_type = "azurerm_firewall"
  #     key = "firewall1"
  #     # or
  #     # id = ""
  #   }
  # }
}


vnets = {
  vnet1 = {
    resource_group_key = "vnets"
    vnet = {
      name          = "vnet"
      address_space = ["172.10.0.0/16"]
    }
  }
}

virtual_hub_connections = {
  vnet_to_hub = {
    name = "vnets-TO-vhub"
    virtual_hub = {
      key = "hub1"
    }
    vnet = {
      vnet_key = "vnet1"
    }
    # to route internet traffic through firewall in secure hub, set internet_security_enabled to true
    internet_security_enabled = true
    routing = {
      firewall_manager = {
        virtual_hub_route_table_key = "defaultRouteTable"
        propagated_route_table = {
          # To route vnet to vnet traffic through firewall manager (private traffic)
          labels = ["none"]
          # Route internet traffic through firewall manager (private traffic)
          virtual_hub_route_table_keys = ["noneRouteTable"]
        }
      }
    }
  }
}