global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  rg1 = {
    name   = "azure_monitor"
    region = "region1" 
  }
}

private_dns = {
  dns_monitor = {
    name               = "privatelink.monitor.azure.com"
    resource_group_key = "rg1"
  }

  dns_oms = {
    name               = "privatelink.oms.opinsights.azure.com"
    resource_group_key = "rg1"
  }

  dns_ods = {
    name               = "privatelink.ods.opinsights.azure.com"
    resource_group_key = "rg1"
  }

  dns_agentsvc = {
    name               = "privatelink.agentsvc.azure-automation.net"
    resource_group_key = "rg1"
  }

  dns_sa = {
    name               = "privatelink.blob.core.windows.net"
    resource_group_key = "rg1"
  }
}

monitor_private_link_scope = {
  mpls1 = {
    name = "mpls"

    resource_group = {
      key = "rg1"
    }
    # add log analytics resource id
    linked_resource_id = "/subscriptions/********-****-****-****-************/resourceGroups/****/providers/Microsoft.OperationalInsights/workspaces/****"

    private_endpoints = {
      mpls_pl = {
        name               = "mpls-pep"
        # add private endpoint subnet id 
        subnet_id          = "****" 
        resource_group_key = "rg1"

        private_service_connection = {
          name                 = "mpls-psc"
          is_manual_connection = false
          subresource_names    = ["azuremonitor"]
        }

        private_dns = {
          zone_group_name = "mpls-default"
          # lz_key          = "private_dns"   # use if the DNS keys are deployed in a remote landingzone
          keys            = ["dns_monitor", "dns_oms", "dns_ods", "dns_agentsvc", "dns_sa"]
        }
      }
    }
  }
}