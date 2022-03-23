global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiacentral"
    region2 = "westeurope"
  }
}

resource_groups = {
  rg = {
    name   = "aadds"
    region = "region1"
  }
}

## You need to register in your tenant the well-known GUID for AADDS. If you have permissions you can do it with this code or ask the directory team to do it first
## https://docs.microsoft.com/en-us/azure/active-directory-domain-services/alert-service-principal#recreate-a-missing-service-principal

azuread_service_principals = {
  aadds = {
    azuread_application = {
      application_id = "2565bd9d-da50-47d4-8b85-4c97f669dc36"
    }
  }
}

### The principal running this Terraform deployment must be Global Admin to deploy AADDS

active_directory_domain_service = {
  adds = {
    name   = "aadds-widgetslogin-net"
    region = "region1"
    resource_group = {
      key = "rg"
    }
    domain_name           = "widgetslogin.net"
    sku                   = "Enterprise"
    filtered_sync_enabled = false

    initial_replica_set = {
      region = "region1"
      subnet = {
        vnet_key = "vnet_aadds_re1"
        key      = "aadds"
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

# You need Enteprise - Premium SKU for replicat_sets
active_directory_domain_service_replica_set = {
  aadds_region2 = {
    region = "region2"
    active_directory_domain_service = {
      key = "adds"
    }
    subnet = {
      vnet_key = "vnet_aadds_re2"
      key      = "aadds"
    }
  }
}