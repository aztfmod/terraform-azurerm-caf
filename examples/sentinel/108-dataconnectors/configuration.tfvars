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

# sentinel_dc_aad = {
#   aad1 = {
#     name = "example-dcaad"
#     log_analytics_workspace = {
#       #lz_key = ""
#       key = "law1"
#     }
#   }
# }

# sentinel_dc_app_security = {
#   as1 = {
#     name = "example=dcappsec"
#     log_analytics_workspace = {
#       #lz_key = ""
#       key = "law1"
#     }
#   }
# }

# sentinel_dc_aws = {
#   aws1 = {
#     name = "example-aws"
#     log_analytics_workspace = {
#       #lz_key = ""
#       key = "law1"
#     }
#     aws_role_arn = "arn:aws:iam::000000000000:role/role1"
#   }
# }

# sentinel_dc_azure_threat_protection = {
#   atp1 = {
#     name = "example-tp"
#     log_analytics_workspace = {
#       #lz_key = ""
#       key = "law1"
#     }
#   }
# }

# Need to add consent
# sentinel_dc_ms_threat_protection = {
#   mtp1 = {
#     name = "example-ms"
#     log_analytics_workspace = {
#       #lz_key = ""
#       key = "law1"
#     }
#   }
# }

# sentinel_dc_office_365 = {
#   office1 = {
#     name = "example-office"
#     log_analytics_workspace = {
#       #lz_key = ""
#       key = "law1"
#     }
#     teams_enabled = "false"
#   }
# }

sentinel_dc_security_center = {
  sc1 = {
    name = "example-sc"
    log_analytics_workspace = {
      #lz_key = ""
      key = "law1"
    }
  }
}

# sentinel_dc_threat_intelligence = {
#   ti1 = {
#     name = "example-ti"
#     log_analytics_workspace = {
#       #lz_key = ""
#       key = "law1"
#     }
#   }
# }
