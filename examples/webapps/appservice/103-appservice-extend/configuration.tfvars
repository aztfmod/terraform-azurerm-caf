global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  webapp_extend = {
    name   = "webapp-extend"
    region = "region1"
  }
}

# By default asp1 will inherit from the resource group location
app_service_plans = {
  asp_extend = {
    resource_group_key = "webapp_extend"
    name               = "asp-extend"

    sku = {
      tier = "Standard"
      size = "S1"
    }
  }
}

app_services = {
  webapp1 = {
    resource_group_key   = "webapp_extend"
    name                 = "webapp-extend"
    app_service_plan_key = "asp_extend"

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

      # For diagnostic settings
      diagnostic_profiles = {
        app_service = {
          definition_key   = "app_service"
          destination_type = "event_hub"      
          destination_key  = "central_logs"   # Needs to be created in launchpad
        }
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
         ["AppServiceAntivirusScanAuditLogs", true, false, 7],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
         ["AllMetrics", true, false, 7],
      ]
    }
  }

}