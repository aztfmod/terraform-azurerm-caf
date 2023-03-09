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

web_pubsubs = {
  wps1 = {
    name = "web_pubsub_1"
    sku  = "Free_F1"
    resource_group = {
      key = "wps_examples"
    }
    region = "region1"
  }
}

web_pubsub_hubs = {
  hub1 = {
    name = "hub1"
    web_pubsub = {
      key = "wps1"
    }
    event_handler = {
      ev1 = {
        url_template       = "https://test.com/api/{hub}/{event}"
        user_event_pattern = "event1, event2"
        system_events      = ["connected"]
      }
    }
    anonymous_connections_enabled = true
  }
  # hub2 = {
  #   name          = "hub2"
  #   web_pubsub_id = "/subscriptions/0000-0000-0000-0000-0000/resourceGroups/myPubSubRg/providers/Microsoft.SignalRService/WebPubSub/myPubSub1"
  #   event_handler = {
  #     ev1 = {
  #       url_template       = "https://test.com/api/{hub}/{event}"
  #       user_event_pattern = "event1, event2"
  #       system_events      = ["connected"]
  #     }
  #   }
  #   anonymous_connections_enabled = true
  # }
}