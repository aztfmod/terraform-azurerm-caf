app_service_plans = {
  asp_logic_app = {
    resource_group_key = "logic_app_rg"
    name               = "logicapp1asp"

    sku = {
      tier = "WorkflowStandard"
      size = "WS1"
    }
  }
}