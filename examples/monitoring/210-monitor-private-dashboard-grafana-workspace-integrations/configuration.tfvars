global_settings = {
  regions = {
    region1 = "australiaeast"
  }
  inherit_tags = true
  tags = {
    example = "monitoring/210-monitor-private-dashboard-grafana-workspace-integrations"
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
      lz_key = "examples"
      key    = "grafana_re1"
    }

    identity = {
      type = "SystemAssigned"
    }

    api_key_enabled                        = true
    auto_generated_domain_name_label_scope = "TenantReuse"
    deterministic_outbound_ip_enabled      = true
    public_network_access_enabled          = true
    grafana_major_version                  = 10
    sku                                    = "Standard"
    zone_redundancy_enabled                = false

    vnet = {
      lz_key = "examples"
      key    = "grafana_re1"
    }
  }
}

monitor_dashboard_grafana_workspace_integrations = {
  grafana_re1 = {
    monitor_dashboard_grafana = {
      lz_key = "examples"
      key    = "grafana_re1"
      workspaces = [
        {
          id = "/subscriptions/c0effcf9-3741-47a8-b3af-541e25549917/resourcegroups/rg-srecced-platform-a0b/providers/microsoft.monitor/accounts/mw-srecced-platform-a0b"
        },
        {
          id = "/subscriptions/c0effcf9-3741-47a8-b3af-541e25549917/resourcegroups/rg-srecced-platform-a0b/providers/microsoft.monitor/accounts/mw-srecced-platform-321"
        }

      ]
    }
  }
}
