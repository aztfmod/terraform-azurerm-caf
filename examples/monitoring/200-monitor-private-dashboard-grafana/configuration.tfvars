global_settings = {
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  grafana_re1 = {
    name   = "grafana-re1"
    region = "region1"
  }
}

monitor_dashboard_grafana = {
  grafana_re1 = {
    name = "grafana-re1-001"

    resource_group = {
      lz_key = "region1"
      key    = "grafana_re1"
    }

    identity = {
      type = "SystemAssigned"
    }

    api_key_enabled                        = true
    auto_generated_domain_name_label_scope = "TenantReuse"
    deterministic_outbound_ip_enabled      = true
    public_network_access_enabled          = false
    grafana_major_version                  = 10
    sku                                    = "Standard"
    zone_redundancy_enabled                = false

    vnet = {
      lz_key = "region1"
      key    = "grafana_re1"
    }

    diagnostic_profiles = {
      logs = {
        name             = "dg-operations-logs"
        definition_key   = "dashboard_grafana_logs"
        destination_type = "log_analytics"
        destination_key  = "central_logs_region1"
      }
    }
  }
}
