global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  rg1 = {
    name = "example-rg"
  }
}

log_analytics = {
  law1 = {
    name               = "example-workspace"
    resource_group_key = "rg1"
    solutions_maps = {
      SecurityInsights = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/SecurityInsights"
      }
    }
  }
}

sentinel_ar_scheduled = {
  ars1 = {
    name = "example-scheduled-alert-rule"
    log_analytics_workspace = {
      #lz_key = ""
      key = "law1"
    }
    display_name = "example-scheduled-alert-rule"
    severity     = "Low"
    query        = <<QUERY
      AzureActivity |
      where OperationName == "Create or Update Virtual Machine" or OperationName =="Create Deployment" |
      where ActivityStatus == "Succeeded" |
      make-series dcount(ResourceId) default=0 on EventSubmissionTimestamp in range(ago(7d), now(), 1d) by Caller
    QUERY
    event_grouping = {
      aggregation_method = "AlertPerResult" //SingleAlert
    }
    incident_configuration = {
      create_incident = true
      grouping = {
        enabled = "false"
      }
    }
  }
}
