global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  rg1 = {
    name   = "example-redis"
    region = "region1"
  }
}

azurerm_redis_caches = {
  redis1 = {
    resource_group_key = "rg1"
    redis = {
      name     = "redis-std-1"
      capacity = 2
      family   = "C"
      sku_name = "Standard"
    }
    tags = {
      test = "AK1"
    }

    diagnostic_profiles = {
      redis_cache = {
        definition_key   = "redis_cache"
        destination_type = "event_hub"
        destination_key  = "central_logs_example"
      }
    }
  }
}

diagnostic_event_hub_namespaces = {
  event_hub_namespace1 = {
    name               = "security_operation_logs"
    resource_group_key = "rg1"
    sku                = "Standard"
    region             = "region1"
  }
}

diagnostics_destinations = {
  event_hub_namespaces = {
    central_logs_example = {
      event_hub_namespace_key = "event_hub_namespace1"
    }
  }
}


diagnostics_definition = {
  redis_cache = {
    name = "operational_logs_and_metrics"

    categories = {
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 7],
      ]
    }
  }
}
