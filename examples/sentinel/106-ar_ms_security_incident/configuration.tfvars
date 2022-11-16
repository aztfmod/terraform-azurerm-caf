global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  rg1 = {
    name = "sentinal"
  }
}

log_analytics = {
  law1 = {
    name               = "sentinal-automation-rule"
    resource_group_key = "rg1"
    solutions_maps = {
      SecurityInsights = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/SecurityInsights"
      }
    }
  }
}

sentinel_ar_ms_security_incidents = {
  arm1 = {
    name = "example-ms-security-incident-alert-rule"
    log_analytics_workspace = {
      #lz_key = ""
      key = "law1"
    }
    product_filter  = "Microsoft Cloud App Security"
    display_name    = "example rule"
    severity_filter = ["Low"]
  }
}
