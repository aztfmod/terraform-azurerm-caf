# Create log analytics workspace with Updates solution and linked automation account
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  automation = {
    name = "automation"
  }
}

automations = {
  auto1 = {
    name               = "automation"
    sku                = "basic"
    resource_group_key = "automation"
  }
}

diagnostic_log_analytics = {
  region1 = {
    region             = "region1"
    name               = "logre1"
    resource_group_key = "automation"
    solutions_maps = {
      Updates = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/Updates"
      }
    }
  }
}

automation_log_analytics_links = {
  link1 = {
    workspace_key          = "region1"
    automation_account_key = "auto1"
    resource_group_key     = "automation"
  }
}

automation_software_update_configurations = { # https://docs.microsoft.com/en-us/azure/templates/microsoft.automation/automationaccounts/softwareupdateconfigurations
  config1 = {
    automation_account_key = "auto1"
    resource_group_key     = "automation"
    update_config = {
      properties = {
        scheduleInfo = {
          startTime = "2022-07-01T07:00:00+00:00"
          isEnabled = true
          interval  = 1
          frequency = "Day"
          timeZone  = "Etc/UTC"
        }
        updateConfiguration = {
          operatingSystem = "Windows"
          windows = {
            includedUpdateClassifications = "Critical"
            rebootSetting                 = "IfRequired"
          }
          targets = {
            azureQueries = [
              {
                locations = ["westeurope"]
                scope = [
                  "/subscriptions/370e92be-cdb8-4a7a-af85-e996b3706e58"
                ]
                tagSettings = {
                  filterOperator = "All"
                  tags = {
                    "level" = ["level0", "level1"]
                  }
                }
              }
            ]
          }
        }
      }
    }
  }
}