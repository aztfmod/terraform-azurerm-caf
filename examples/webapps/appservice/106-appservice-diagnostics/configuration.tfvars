global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  webapprg = {
    name   = "webapp-diagnostics"
    region = "region1"
  }
}


diagnostic_event_hub_namespaces = {
  event_hub_namespace1 = {
    name               = "security_operation_logs"
    resource_group_key = "webapprg"
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

# By default asp1 will inherit from the resource group location
app_service_plans = {
  asp_diag = {
    resource_group_key = "webapprg"
    name               = "asp-diag"

    sku = {
      tier = "Standard"
      size = "S1"
    }
  }
}

app_services = {
  webapp1 = {
    resource_group_key   = "webapprg"
    name                 = "webapp-diagnostics"
    app_service_plan_key = "asp_diag"

    identity = {
      type = "SystemAssigned"
    }

    settings = {
      enabled                 = true
      numberOfWorkers         = 2
      client_affinity_enabled = false
      client_cert_enabled     = false
      https_only              = false

      site_config = {
        default_documents        = ["main.aspx"]
        always_on                = true
        dotnet_framework_version = "v4.0"
        app_command_line         = null         ///sbin/myserver -b 0.0.0.0
        ftps_state               = "AllAllowed" //AllAllowed, FtpsOnly and Disabled
        http2_enabled            = false

      }

      app_settings = {
        "Example" = "Extend",
        "LZ"      = "CAF"
      }

      tags = {
        Department = "IT"
      }
    }

    diagnostic_profiles = {
      app_service = {
        definition_key   = "app_service"
        destination_type = "event_hub"
        destination_key  = "central_logs_example" # Needs to be created in launchpad
      }
    }
  }
}

# For diagnostic settings
diagnostics_definition = {
  app_service = {
    name = "operational_logs_and_metrics"

    categories = {
      log = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AppServiceHTTPLogs", true, false, 7],
        ["AppServiceConsoleLogs", true, false, 7],
        ["AppServiceAppLogs", true, false, 7],
        ["AppServiceAuditLogs", true, false, 7],
        ["AppServiceIPSecAuditLogs", true, false, 7],
        ["AppServicePlatformLogs", true, false, 7],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 7],
      ]
    }
  }

}