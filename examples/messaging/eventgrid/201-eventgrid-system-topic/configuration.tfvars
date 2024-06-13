global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  evg_examples = {
    name   = "eventgrid"
    region = "region1"
  }
}

storage_accounts = {
  evg_storage = {
    name                          = "storage"
    resource_group_key            = "evg_examples"
    region                        = "region1"
    account_kind                  = "StorageV2"
    account_tier                  = "Standard"
    account_replication_type      = "LRS"
  }
}

servicebus_namespaces = {
  evg_service_bus = {
    resource_group = {
      key = "eventgrid"
    }
    name = "eventgrid"
    sku  = "Standard"
    namespace_auth_rules = {
      rule1 = {
        name   = "rule1"
        listen = true
        send   = true
        manage = false
      }
    }
  }
}

servicebus_queues = {
  eventgrid_queue = {
    name = "eventgrid-queue"
    servicebus_namespace = {
      key = "evg_service_bus"
    }
    max_delivery_count    = 10
    max_size_in_megabytes = 1024
    default_message_ttl   = "P0Y0M14DT0H0M0S"
    queue_auth_rules = {
      rule1 = {
        name   = "qauthrule1"
        listen = true
        send   = false
        manage = false
      }
    }
  }
}

eventgrid_system_topic = {
  evg_system_topic = {
    name = "eventgrid-topic"
    topic = {
      resource_type = "storage_accounts"
      resource_key  = "evg_storage"
    }
    topic_type = "Microsoft.Storage.StorageAccounts"
  }
}

eventgrid_system_topic_event_subscription = {
  blob-created = {
    name = "blob-created"
    scope = {
      key = "evg_system_topic"
    }
    servicebus_queues = {
      key = "eventgrid_queue"
    }
    subject_filter = {
      subject_ends_with   = ".pdf"
    }
    included_event_types = ["Microsoft.Storage.BlobCreated"]
  }
}
