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

event_hub_namespaces = {
  evh1 = {
    name               = "evh1"
    resource_group_key = "sec_center"
    sku                = "Standard"
    region             = "region1"
  }
}

security_center_automation = {
  automation1 = {
    name = "sec-center"
    resource_group_key = "sec_center"
    type = "EventHub"
    eventhub_namespace_key = "evh1"
    eventhub_data = {
      action1= {
        type = "EventHub"
      }
    }
    source = {
      source1= {
        event_source = "Assessments"
        ruleset = {
          ruleset1 ={
            property_path  = "properties.metadata.severity"
            operator       = "Equals"
            expected_value = "High"
            property_type  = "String"
          }
          
        }
      }
    }

  }

}
