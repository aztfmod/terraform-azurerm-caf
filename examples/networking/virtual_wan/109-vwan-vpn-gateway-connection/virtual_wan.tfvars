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

    hubs = {
      hub_re1 = {
        hub_name           = "hub-re1"
        region             = "region1"
        hub_address_prefix = "10.0.3.0/24"
        deploy_p2s         = false
        p2s_config         = {}
        deploy_s2s         = true
        s2s_config = {
          name       = "caf-sea-vpn-s2s"
          scale_unit = 1
        }
        deploy_er = false
      }
    }
  }
}

virtual_hub_route_tables = {
  routetable1 = {
    name = "example-vhubroutetable1"

    virtual_wan_key = "vwan_re1"
    virtual_hub_key = "hub_re1"

    labels = ["label1", "default"]
  }
  routetable2 = {
    name = "example-vhubroutetable2"

    virtual_wan_key = "vwan_re1"
    virtual_hub_key = "hub_re1"

    labels = ["label2"]
  }
}

vpn_sites = {
  vpn-site-1 = {
    name          = "vpn-site-1"
    address_cidrs = ["1.2.3.0/24", "4.5.6.0/24"]
    device_vendor = "Cisco"
    device_model  = "800"

    resource_group = {
      key = "hub_re1"
    }

    virtual_wan = {
      key = "vwan_re1"
    }

    links = {
      primary = {
        name          = "primary"
        ip_address    = "1.2.3.4"
        provider_name = "Microsoft"
        speed_in_mbps = "150"
      }
      secondary = {
        name          = "secondary"
        fqdn          = "secondary.link.com"
        provider_name = "Microsoft"
        speed_in_mbps = "50"
        # bgp = {
        #   asn             = "65534"
        #   peering_address = "169.254.1.2"
        # }
      }
    }
  }
}

vpn_gateway_connections = {
  connection-1 = {
    name                      = "connection-1"
    internet_security_enabled = false

    # vpn_site_id = "" # Set the Resource ID of an existing VPN Site
    vpn_site = {
      # lz_key = "vpns" # Set the 'lz_key' of a VPN Site created in a remote deployment
      key = "vpn-site-1" # Set the 'key' of the VPN Site created in this (or a remote) deployment
    }
    virtual_wan = {
      key = "vwan_re1"
    }
    # virtual_hub_gateway_id = "" # Set the Resource ID of an existing Virtual Hub's VPN Gateway
    virtual_hub = {
      # lz_key = "" # Set the 'lz_key' of a Virtual Hub created in a remote deployment
      key = "hub_re1" # Set the 'key' of the Virtual Hub created in this (or a remote) deployment
    }

    vpn_links = {
      link-1 = {
        link_index                             = 0 # Index order of VPN Site's Link
        name                                   = "link-1"
        bandwidth_mbps                         = "100"       # Optional
        bgp_enabled                            = false       # Optional
        protocol                               = "IKEv2"     # Optional
        ratelimit_enabled                      = true        # Optional
        route_weight                           = "100"       # Optional
        shared_key                             = "abc123456" # Optional
        local_azure_ip_address_enabled         = false       # Optional
        policy_based_traffic_selectors_enabled = false       # Optional

        ipsec_policies = { # Optional
          policy1 = {
            dh_group                 = "DHGroup14"
            ike_encryption_algorithm = "AES256"
            ike_integrity_algorithm  = "SHA256"
            encryption_algorithm     = "AES256"
            integrity_algorithm      = "SHA256"
            pfs_group                = "PFS14"
            sa_data_size_kb          = "102400000"
            sa_lifetime_sec          = "27000"
          }
        }
      }
      # link-2 = {
      #   link_index = 1
      #   name = "link-2"
      # }
    }

    routing = { # Optional
      # associated_route_table = { # Can only be Default Route Table https://learn.microsoft.com/en-us/azure/virtual-wan/about-virtual-hub-routing#considerations
      # id = "" # Set the Resource ID of an existing Virtual WAN Route Table
      # lz_key = "" # Set the 'lz_key' of a Route Table created in a remote deployment
      # key = "routetable1" # Set the 'key' of the Route Table created in this (or a remote) deployment
      # }

      propagated_route_table = {
        route_tables = {
          routetable1 = {
            # id = "" # Set the Resource ID of an existing Virtual WAN Route Table
            # lz_key = "" # Set the 'lz_key' of a Route Table created in a remote deployment
            key    = "routetable1" # Set the 'key' of the Route Table created in this (or a remote) deployment
            labels = ["label1"]    # Optional
          }
          routetable2 = {
            # id = "" # Set the Resource ID of an existing Virtual WAN Route Table
            # lz_key = "" # Set the 'lz_key' of a Route Table created in a remote deployment
            key    = "routetable2"         # Set the 'key' of the Route Table created in this (or a remote) deployment
            labels = ["label2", "default"] # Optional
          }
        }
      }
    }
  }
}
