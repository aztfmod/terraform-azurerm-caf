global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  rg1 = {
    name   = "example-adt"
    region = "region1"
  }
}


event_hub_namespaces = {
  evh1 = {
    name               = "evh1"
    resource_group_key = "rg1"
    sku                = "Standard"
    region             = "region1"
  }
}

event_hubs = {
  ev = {
    name                    = "ev"
    resource_group_key      = "rg1"
    event_hub_namespace_key = "evh1"
    storage_account_key     = "evh1"
    blob_container_name     = "evh"
    partition_count         = "2"
    message_retention       = "2"
  }
}

event_hub_auth_rules = {
  rule1 = {
    resource_group_key      = "rg1"
    event_hub_namespace_key = "evh1"
    event_hub_name_key      = "ev"
    rule_name               = "ev-rule"
    listen                  = false
    send                    = true
    manage                  = false
  }
}


digital_twins_instances = {
  adt1 = {
    name               = "example-adt"
    region             = "region1"
    resource_group_key = "rg1"

  }
}

digital_twins_endpoint_eventhubs = {
  adtee1 = {
    name                       = "example-epev"
    digital_twins_instance_key = "adt1"
    event_hub_auth_rules_key   = "rule1"

  }
}

