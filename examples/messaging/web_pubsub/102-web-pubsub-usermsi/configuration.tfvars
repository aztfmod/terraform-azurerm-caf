global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  wps_examples = {
    name   = "webpubsub"
    region = "region1"
  }
}

managed_identities = {
  hub_usermsi = {
    name               = "hub-useraccess"
    resource_group_key = "wps_examples"
  }
}

web_pubsubs = {
  wps1 = {
    name = "web_pubsub_1"
    sku  = "Free_F1"
    resource_group = {
      key = "wps_examples"
    }
    region = "region1"
    identity = {
      type                  = "UserAssigned"
      managed_identity_keys = ["hub_usermsi"]
    }
  }
}

web_pubsub_hubs = {
  hub1 = {
    name = "tfex-wpsh"
    web_pubsub = {
      key = "wps1"
    }
    event_handler = {
      ev1 = {
        url_template       = "https://test.com/api/{hub}/{event}"
        user_event_pattern = "event1"
        system_events      = ["connected"]
        auth = {
          managed_identity_key = "hub_usermsi"
        }
      }
    }
    anonymous_connections_enabled = true
  }
}