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
}

event_hub_namespaces = {
  evh1 = {
    name               = "evh1"
    resource_group_key = "ioth_region1"
    sku                = "Standard"
    region             = "region1"
  }
}

event_hubs = {
  ev = {
    name                    = "ev"
    resource_group_key      = "ioth_region1"
    event_hub_namespace_key = "evh1"
    storage_account_key     = "evh1"
    blob_container_name     = "evh"
    partition_count         = "2"
    message_retention       = "2"
  }
}

event_hub_auth_rules = {
  rule1 = {
    resource_group_key      = "ioth_region1"
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
    name                     = "sa1dev"
    resource_group_key       = "ioth_region1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    containers = {
      sa1 = {
        name = "random"
      }
    }
  }
}

managed_identities = {
  iot_usermsi = {
    name               = "iot"
    resource_group_key = "ioth_region1"
  }
}

iot_hub = {
  ioth1 = {
    name               = "iot_hub_1"
    region             = "region1"
    resource_group_key = "ioth_region1"
    identity = {
      type                  = "SystemAssigned, UserAssigned"
      managed_identity_keys = ["iot_usermsi"]
    }
    sku = {
      name     = "S1"
      capacity = "1"
    }
    endpoints = {
      eventhub = {
        resource_group = {
          key = "ioth_region1"
        }
        type                = "AzureIotHub.EventHub"
        authentication_type = "identityBased"
        event_hub_namespace = {
          key = "evh1"
        }
        event_hub = {
          key = "ev"
        }
        identity = {
          key = "iot_usermsi"
        }
      }
      sa_endpoint = {
        resource_group = {
          key = "ioth_region1"
        }
        type                       = "AzureIotHub.StorageContainer"
        authentication_type        = "identityBased"
        batch_frequency_in_seconds = 60
        max_chunk_size_in_bytes    = 10485760
        storage_account = {
          key           = "sa1"
          container_key = "sa1"
        }
        encoding         = "Avro"
        file_name_format = "{iothub}/{partition}_{YYYY}_{MM}_{DD}_{HH}_{mm}"
        identity = {
          key = "iot_usermsi"
        }
      }
    }
    tags = {
      purpose = "testing"
    }
  }
}

role_mapping = {
  built_in_role_mapping = {
    storage_accounts = {
      "sa1" = {
        "Storage Blob Data Contributor" = {
          managed_identities = {
            keys = ["iot_usermsi"]
          }
        }
      }
    }
    event_hub_namespaces = {
      "evh1" = {
        "Contributor" = {
          managed_identities = {
            keys = ["iot_usermsi"]
          }
        }
      }
    }
  }
}
