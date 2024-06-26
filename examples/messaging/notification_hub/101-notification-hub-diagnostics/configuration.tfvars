global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  rg1 = {
    name   = "notification-hub"
    region = "region1"
  }
}

notification_hub_namespaces = {
  nh_ns1 = {
    name               = "nh_ns1"
    resource_group_key = "rg1"
    namespace_type     = "NotificationHub"
    region             = "region1"
    sku_name           = "Free"
    enabled            = true
    tags = {
      "environment" = "Dev"
    }
    diagnostic_profiles = {
      notification_hub_namespaces = {
        definition_key   = "notification_hub_namespaces"
        destination_type = "event_hub"
        destination_key  = "central_logs_example"
      }
    }
  }
}

notification_hubs = {
  nh1 = {
    name                            = "nh1"
    namespace_key                   = "nh_ns1"
    resource_group_key              = "rg1"

    auth_rules = {
      ar1 = {
        name   = "ar1"
        manage = true
        send   = true
        listen = true
      }
      ar2 = {
        name   = "ar2"
        manage = false
        send   = true
        listen = false
      }
      ar3 = {
        name   = "ar3"
        manage = false
        send   = false
        listen = true
      }
    }

    # apns_credential = {
    #   application_mode = "Sandbox"
    #   bundle_id        = "com.hashicorp.example"
    #   key_id           = "68B439B1-7474-4A03-B1CF-0646056C3D63"
    #   team_id          = "B50E8835-9857-4E2E-8385-37D3219E8C27"
    #   token            = "uf6piShaijeetu9ogooSei1aeRoosei5ohphuuxohquoh0XeeP"
    # }

    # gcm_credential = {
    #   api_key = "Veech8seifiGothoo7chu6foo6eizoodaiThozePee5Xepi7ee"
    # }

    tags = {
      "environment" = "Dev"
    }
  }
}

notification_hub_auth_rules = {
  ar4 = {
    name                            = "ar4"
    notification_hub_key            = "nh1"
    namespace_key                   = "nh_ns1"
    resource_group_key              = "rg1"
    manage                          = true
    send                            = true
    listen                          = true
  }
}

diagnostic_event_hub_namespaces = {
  event_hub_namespace1 = {
    name               = "security_operation_logs"
    resource_group_key = "rg1"
    sku                = "Standard"
    region             = "region1"
  }
}

diagnostics_destinations = {
  event_hub_namespaces = {
    central_logs_example = {
      event_hub_namespace_key = "event_hub_namespace1"
    }
  }
}

# For diagnostic settings
diagnostics_definition = {
  notification_hub_namespaces = {
    name = "operational_logs"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["OperationalLogs", true, false, 0],
      ]
    }
  }
}