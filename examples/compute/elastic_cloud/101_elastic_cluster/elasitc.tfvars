global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus"
    region2 = "australiacentral"
  }
}

resource_groups = {
  elastic_re1 = {
    name   = "elastic-test"
    region = "region1"
  }
}

elastic_clusters = {
  cluster1 = {
    name                        = "test-mysuper-elastic-cluster"
    elastic_cloud_email_address = "user@example.com"
    sku_name                    = "ess-monthly-consumption_Monthly"
    resource_group = {
      key          = "elastic_re1"
    }
    logs = {
      send_activity_logs        = false
      send_azuread_logs         = false
      send_subscription_logs    = false
      filtering_tags = {
        tag1 = {
          name   = "tags1"
          value  = "test123"
          action = "Include"
        }
        tags2 = {
          name   = "tags2"
          value  = "test345"
          action = "Exclude"          
        }
      }
    }
  }
}
