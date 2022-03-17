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
        hub_name                    = "hub-re1"
        region                      = "region1"
        hub_address_prefix          = "10.0.3.0/24"
        deploy_firewall             = true
        firewall_name               = "hub-fw-re1"
        firewall_resource_group_key = "hub_re1"
        deploy_p2s                  = false
        p2s_config                  = {}
        deploy_s2s                  = false
        s2s_config                  = {}
        deploy_er                   = false
        er_config                   = {}

      }
    }
  }
}

