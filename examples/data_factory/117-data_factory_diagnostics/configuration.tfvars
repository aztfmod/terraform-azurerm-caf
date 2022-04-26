global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  rg1 = {
    name   = "example"
    region = "region1"
  }
}

diagnostic_log_analytics = {
  central_logs_region1 = {
    region             = "region1"
    name               = "logs"
    resource_group_key = "rg1"
  }
}

diagnostics_destinations = {
  # Storage keys must reference the azure region name
  log_analytics = {
    central_logs = {
      log_analytics_key = "central_logs_region1"
    }
  }
}

diagnostics_definition = {
  azure_data_factory = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["ActivityRuns", true, false, 7],
        ["PipelineRuns", true, false, 7],
        ["TriggerRuns", true, false, 7],
        ["SandboxPipelineRuns", true, false, 7],
        ["SandboxActivityRuns", true, false, 7],
        ["SSISPackageEventMessages", true, false, 7],
        ["SSISPackageExecutableStatistics", true, false, 7],
        ["SSISPackageEventMessageContext", true, false, 7],
        ["SSISPackageExecutionComponentPhases", true, false, 7],
        ["SSISPackageExecutionDataStatistics", true, false, 7],
        ["SSISIntegrationRuntimeLogs", true, false, 7],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 7],
      ]
    }
  }
}

data_factory = {
  df1 = {
    name = "example"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name = ""
    }
    diagnostic_profiles = {
      central_logs_region1 = {
        definition_key   = "azure_data_factory"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }

}
