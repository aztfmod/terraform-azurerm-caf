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

vpn_sites = {
  vpn-site-1 = {
    name          = "vpn-site-1"
    address_cidrs = ["1.2.3.0/24", "4.5.6.0/24"]
    device_vendor = "Cisco"
    device_model  = "800"

    resource_group = {
      # lz_key = "vwans" # Set the 'lz_key' of a Resource Group created in a remote deployment
      key = "hub_re1" # Set the 'key' of the Resource Group created in this (or a remote) deployment
    }

    virtual_wan = {
      key = "vwan_re1" # Set the 'key' of the Virtual WAN created in this (or a remote) deployment
      # lz_key = "vwans" # Set the 'lz_key' of a Virtual WAN created in a remote deployment
      #
      # or
      #
      # id = "/subscriptions/{subscriptionId}/resourceGroups/testRG/providers/Microsoft.Network/virtualHubs/westushub/hubRouteTables/defaultRouteTable" # Set the Resource ID of an existing Virtual WAN
      # resource_id = "/subscriptions/[subscription_id]/resourceGroups/qaxu-rg-dns-domain-registrar/providers/Microsoft.Network/dnszones/ml0iaix4xgnz0jqd.com" # Set the Resource ID of an existing Virtual WAN
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
        bgp = {
          asn             = "65534"
          peering_address = "169.254.1.2"
        }
      }
    }
  }
}
