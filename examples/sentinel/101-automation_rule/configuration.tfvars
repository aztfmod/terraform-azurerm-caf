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

logic_app_workflow = {
  applogic1 = {
    name               = "workflow1"
    region             = "region1"
    resource_group_key = "rg1"
    #integration_service_environment_key
    #logic_app_integration_account_key
    #workflow_parameters
    #workflow_schema
    workflow_version = "1.0.0.0"
    #parameters
  }
}

diagnostic_log_analytics = {
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

sentinel_automation_rules = {
  ar1 = {
    name = "e0fa0ba9-cdec-4af2-b218-f2fbfd6b38d7"
    diagnostic_log_analytics_workspace = {
      #lz_key = ""
      key = "law1"
    }
    display_name = "ar1"
    order        = "1"
    #expiration              = ""

    action_incident = {
      ai1 = {
        order  = "1"
        status = "Active"
      }

    }

    # action_playbook = {
    #   ap1 = {
    #     #lz_key = ""
    #     logic_app_key = "applogic1"
    #     order         = "3"
    #   }
    # }

    condition = {
      c1 = {
        operator = "Equals"
        property = "IncidentTitle"
        values   = ["test1", "test2"]
      }
    }


  }
}
