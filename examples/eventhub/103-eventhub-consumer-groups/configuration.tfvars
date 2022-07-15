global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  evh_examples = {
    name = "evh_examples"
  }
}


storage_accounts = {
  evh1 = {
    name                     = "evh1"
    resource_group_key       = "evh_examples"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    containers = {
      evh = {
        name = "evh"
      }
    }
  }
}


event_hub_namespaces = {
  evh1 = {
    name               = "evh1"
    resource_group_key = "evh_examples"
    sku                = "Standard"
    region             = "region1"

    event_hubs = {
      gaming = {
        name = "gaming"
        storage_account = {
          key = "evh1"
        }
        blob_container_name = "evh"
        partition_count     = "2"
        message_retention   = "2"

        auth_rules = {
          mobile_apps_ios = {
            rule_name = "mobile-app-ios"
            listen    = true
            send      = true
            manage    = false
          }
          mobile_apps_android = {
            rule_name = "mobile-app-android"
            listen    = true
            send      = true
            manage    = false
          }
        } // auth_rules

      }
    } // event_hubs

    auth_rules = {
      siem = {
        rule_name = "siem"
        listen    = true
        send      = false
        manage    = false
      }
    } // auth_rules

  }
}

event_hubs = {
  ev = {
    name                    = "ev"
    resource_group_key      = "evh_examples"
    event_hub_namespace_key = "evh1"
    #destination_key        = "central_logs"
    storage_account_key = "evh1"
    blob_container_name = "evh"
    partition_count     = "2"
    message_retention   = "2"
  }
}

event_hub_consumer_groups = {
  cg1 = {
    resource_group_key      = "evh_examples"
    event_hub_namespace_key = "evh1"
    event_hub_name_key      = "ev"
    name                    = "example-cg"
    user_metadata           = "some_metadata"
  }
}