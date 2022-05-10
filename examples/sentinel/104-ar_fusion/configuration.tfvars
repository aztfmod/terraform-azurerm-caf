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

sentinel_ar_fusions = {
  arf1 = {
    name = "example-fusion-alert-rule"
    log_analytics_workspace = {
      #lz_key = ""
      key = "law1"
    }
    alert_rule_template_guid = "f71aba3d-28fb-450b-b192-4e76a83015c8"
  }
}
