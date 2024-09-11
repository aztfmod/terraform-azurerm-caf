global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  evg_examples = {
    name   = "eventgrid"
    region = "region1"
  }
}

eventgrid_system_topic = {
  egt1 = {
    name = "egt1"
    region = "global" # set global when topic_type = "Microsoft.Resources.Subscriptions"
    resource_group = {
      key = "evg_examples"
    }
    topic_type         = "Microsoft.Resources.Subscriptions"
    source_resource_id = "/subscriptions/0b1f6471-1bf0-4dda-aec3-111122223333"
  }
}

## Uncomment this part after deployed function on Azure Function
# eventgrid_system_event_subscription = {
#   egs1 = {
#     name = "egs1"
#     resource_group = {
#       key = "evg_examples"
#     }
#     eventgrid_system_topic = {
#       key = "egt1"
#     }
#     event_delivery_schema = "EventGridSchema"
#     included_event_types  = ["Microsoft.Resources.ResourceWriteSuccess"]
#     azure_function_endpoint = {
#       function_name = "FunctionName" #Set function name after deployed it
#       function_app = {
#         key = "evg_examples"
#       }
#     }
#     advanced_filtering_on_arrays_enabled = true
#     advanced_filters = {
#       string_not_in = [
#         {
#           key   = "data.operationName"
#           value = ["Microsoft.Resources/tags/write"]
#         }
#       ]
#     }
#   }
# }



