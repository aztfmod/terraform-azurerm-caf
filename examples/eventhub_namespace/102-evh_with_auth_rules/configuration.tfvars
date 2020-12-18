global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  sec_center = {
    name = "sec-center"
  }
}

storage_accounts = {
  evh1 = {
    name                     = "evh1"
    resource_group_key       = "sec_center"
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

event_hub = {
  ev = {
    name = "ev"
    resource_group_key = "sec_center"
    eventhub_namespace_key = "central_logs_region1"
    destination_key        = "central_logs"
    storage_account_key = "evh1"
    blob_container_name = "evh"
    partition_count = "2"
    message_retention = "2"
    rule_name = "ev-rule"
    listen = true
    send =  true
    manage  = false
  }
}