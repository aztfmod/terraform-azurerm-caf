#scenario 200 has to be deployed

global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
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

event_hub_auth_rules = {
  rule1 = {
    resource_group_key      = "evh_examples"
    event_hub_namespace_key = "evh1"
    event_hub_name_key      = "ev"
    rule_name               = "ev-rule"
    listen                  = true
    send                    = true
    manage                  = false
  }
}