
# Event hub diagnostics
diagnostic_event_hub_namespaces = {
  central_logs_region1 = {
    name               = "logs"
    resource_group_key = "ops"
    sku                = "Standard"
    region             = "region1"

    diagnostic_profiles = {
      central_logs_region1 = {
        definition_key   = "event_hub_namespace"
        destination_type = "event_hub"
        destination_key  = "central_logs"
        # eventhub_name = "namespace_to_be_created" #Optional
        # eventhub_authorization_rule_id = "/subscriptions/<sub_id>/resourceGroups/<rg_name>/providers/Microsoft.EventHub/namespaces/<eh_name>/authorizationRules/RootManageSharedAccessKey
      }
    }
  }
}


