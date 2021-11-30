global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastasia"
  }
}

resource_groups = {
  rg1 = {
    name   = "rg1"
    region = "region1"
  }
}

active_directory_domain_service = {
  adds1 = {
    name   = "example-aadds"
    region = "region1"
    resource_group = {
      key = "rg1"
    }
    domain_name           = "widgetslogin.net"
    sku                   = "Enterprise"
    filtered_sync_enabled = false

    initial_replica_set = {
      region = "region1"
      subnet = {
        vnet_key = "vnet1"
        key      = "app"
      }
    }

    notifications = {
      additional_recipients = ["notifyA@example.net", "notifyB@example.org"]
      notify_dc_admins      = true
      notify_global_admins  = true
    }

    security = {
      sync_kerberos_passwords = true
      sync_ntlm_passwords     = true
      sync_on_prem_passwords  = true
    }

    tags = {
      Environment = "prod"
    }
  }
}