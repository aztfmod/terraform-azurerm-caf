global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  rg1 = {
    name   = "eventgrid"
    region = "region1"
  }
}

storage_accounts = {
  sa1 = {
    name                     = "sa1dev"
    resource_group_key       = "rg1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    tags = {
      environment = "dev"
      team        = "IT"
    }
  }
}

storage_account_queues = {
  samplequeue = {
    name                = "samplequeuename"
    storage_account_key = "sa1"
  }
}

eventgrid_event_subscription = {
  egs1 = {
    name = "defaultEventSubscription"
    scope = {
      resource_type = "resource_groups"
      key           = "rg1"
    }

    storage_queue_endpoint = {
      storage_account = {
        key = "sa1"
      }
      queue = {
        key = "samplequeue"
      }
    }
  }
}
