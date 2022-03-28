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

sentinel_ar_ml_behavior_analytics = {
  arm1 = {
    name = "example-ml-alert-rule"
    log_analytics_workspace = {
      #lz_key = ""
      key = "law1"
    }
    alert_rule_template_guid = "737a2ce1-70a3-4968-9e90-3e6aca836abf"
  }
}
