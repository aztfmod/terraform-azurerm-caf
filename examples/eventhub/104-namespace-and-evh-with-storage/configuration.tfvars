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

    capture_description = {
      enabled             = true
      encoding            = "Avro"
      interval_in_seconds = 900

      destination = {
        name                = "EventHubArchive.AzureBlockBlob"
        archive_name_format = "{Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}"
        blob_container_name = "evh"
        storage_account_key = "evh1"
      }
    }

  }
}