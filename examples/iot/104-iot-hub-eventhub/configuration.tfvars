global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westeurope"
  }
}

resource_groups = {
  ioth_region1 = {
    name   = "iothub-rg1"
    region = "region1"
  } 
  evh_examples = {
    name = "evh_examples"
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
    storage_account_key     = "evh1"
    blob_container_name     = "evh"
    partition_count         = "2"
    message_retention       = "2"
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

storage_accounts = {
  sa1 = {
    name = "sa1dev"
    resource_group_key = "ioth_region1" 
    account_kind = "BlobStorage"
    account_tier = "Standard"
    account_replication_type = "LRS"
    containers = {
      sa1 = {
        name = "random"
      }
    } 
  }
}

iot_hub = {
  ioth1 = {
    name               = "iot_hub_1"
    region             = "region1"
    resource_group_key = "ioth_region1"
    identity = {
      type = "SystemAssigned"
      identity_ids = ["1234"]
    }
    sku = {
      name     = "S1"
      capacity = "1"
    }
    endpoints = {
      eventhub = {
        type = "AzureIotHub.EventHub"
        event_hub_auth_rules_key = "rule1"
      }
      sa_endpoint = {
        type                       = "AzureIotHub.StorageContainer"
        batch_frequency_in_seconds = 60
        max_chunk_size_in_bytes    = 10485760
        storage_account_key        = "sa1"
        container_name_key         = "sa1"
        encoding                   = "Avro"
        file_name_format           = "{iothub}/{partition}_{YYYY}_{MM}_{DD}_{HH}_{mm}"
      }
    }
    routes = {
      export = {
        source         = "DeviceMessages"
        condition      = "true"
        endpoint_names = ["export"]
        enabled        = true
      }
      export2 = {
        source         = "DeviceMessages"
        condition      = "true"
        endpoint_names = ["export2"]
        enabled        = true
      }
    }
    enrichment = {
      key            = "tenant"
      value          = "$twin.tags.Tenant"
      endpoint_names = ["export", "export2"]
    }
    tags = {
      purpose = "testing"
    }
  }
}
