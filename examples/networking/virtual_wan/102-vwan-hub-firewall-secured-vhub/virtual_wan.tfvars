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
    # region            = {
    #   key  = "region1"
    # }
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
            source_addresses  = ["192.168.12.0/23"]
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
            source_addresses      = ["192.168.12.0/23"]
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

virtual_hub_route_tables = {
  routetable1 = {
    name = "internet-egress"

    virtual_hub = {
      key = "hub1"
      # lz_key = "connectivity_virtual_hub1"
    }

    labels = ["label1", "default"]
    routes = {
      egress_internet = {
        name              = "egress-internet"
        destinations_type = "CIDR"
        destinations      = ["0.0.0.0/0"]

        # #   # Either next_hop or next_hop_id can be used
        # #   # When using next_hop, the virtual_hub_connection must be deployed in a different landingzone. This cannot be tested in the standalone module.
        # #   # Will be covered in the landingzone starter production configuration in future releases.
        next_hop = {
          # lz_key        = "secazfw1" #
          resource_type = "azurerm_firewalls" # Only supported value in case secured hub.
          key           = "firewall1"
        }
        # # #   #to cather for external object
        #   next_hop_id       = "Azure_Resource_ID"
      }
    }
  }
  # routetable2 = {
  #   name = "example-vhubroutetable2"

  #   virtual_hub = {
  #     key = "hub1"
  #   }

  #   labels = ["label2"]
  # }
}