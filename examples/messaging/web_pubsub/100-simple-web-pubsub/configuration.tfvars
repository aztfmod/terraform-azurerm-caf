global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
  inherit_tags = true
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
    tags = {
      Contributor = "Bravent"
    }

    public_network_access_enabled = false

    live_trace = {
      enabled                   = true
      messaging_logs_enabled    = true
      connectivity_logs_enabled = false
    }

    identity = {
      type = "SystemAssigned"
    }
  }
}
