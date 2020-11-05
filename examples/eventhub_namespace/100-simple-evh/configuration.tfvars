resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  evh_examples = {
<<<<<<< HEAD
    name   = "eventhub"
=======
    name = "eventhub"
>>>>>>> 26c5af3f4a89bec1bca1fa9b304dd5dd5fe20aef
    region = "region1"
  }
}

event_hub_namespaces = {
  evh1 = {
<<<<<<< HEAD
    name               = "evh1"
    resource_group_key = "evh_examples"
    sku                = "Standard"
    region             = "region1"
=======
    name                       = "evh1"
    resource_group_key         = "evh_examples"
    sku                        = "Standard"
    region                     = "region1"
>>>>>>> 26c5af3f4a89bec1bca1fa9b304dd5dd5fe20aef
  }
}

