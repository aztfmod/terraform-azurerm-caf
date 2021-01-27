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



event_hub_namespaces = {
  evh1 = {
    name               = "evh1"
    resource_group_key = "evh_examples"
    sku                = "Standard"
    region             = "region1"
  }
}

event_hub = {
  ev = {
    name = "ev"
    resource_group_key = "evh_examples"
    event_hub_namespace_key = "evh1"
    #destination_key        = "central_logs"
    storage_account_key = "evh1"
    blob_container_name = "evh"
    partition_count = "2"
    message_retention = "2"
  }
}

event_hub_consumer_groups = {
  cg1 ={
    resource_group_key = "evh_examples"
    event_hub_namespace_key = "evh1"
    event_hub_name_key      = "ev"
    name = "example-cg"
    user_metadata = "some_metadata"
  }
}