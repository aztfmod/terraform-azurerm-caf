global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  rg1 = {
    name = "appservice-autoscale-rg"
  }
}

app_service_plans = {
  asp1 = {
    resource_group_key = "rg1"
    name               = "asp-simple"

    maximum_elastic_worker_count = 5

    sku = {
      tier = "Standard"
      size = "S1"
      # per_site_scaling   = true
    }
  }
}

app_services = {
  webapp1 = {
    resource_group_key   = "rg1"
    name                 = "webapp-simple-autoscale"
    app_service_plan_key = "asp1"

    settings = {
      enabled = true
    }
  }
}

monitor_autoscale_settings = {
  mas1 = {
    name               = "mas1"
    enabled            = true
    resource_group_key = "rg1"

    target_resource = {
      # lz_key = ""
      # vmss_key = ""
      app_service_plan_key = "asp1"
    }

    profiles = {
      profile1 = {
        name = "profile1"

        capacity = {
          default = 1
          minimum = 1
          maximum = 3
        }

        rules = {
          rule1 = {
            metric_trigger = {

              # metric_name = "Percentage CPU" # vmss uses this
              # You can also choose your resource id manually, in case it is required
              # metric_resource_id = "/subscriptions/manual-id"
              metric_name      = "CpuPercentage"
              metric_namespace = "microsoft.web/serverfarms"
              time_grain       = "PT1M"
              statistic        = "Average"
              time_window      = "PT10M"
              time_aggregation = "Average"
              operator         = "GreaterThan"
              threshold        = 70
              # You can optionally fill the following fields

              # divide_by_instance_count = true

              # dimensions = {
              #   dimension1 = {
              #     name     = "App1"
              #     operator = "Equals"
              #     values   = []
              #   }

              # }

            }
            scale_action = {
              direction = "Increase"
              type      = "ChangeCount"
              value     = "1"
              cooldown  = "PT5M"
            }

          }
        }

      }
    }
  }
}