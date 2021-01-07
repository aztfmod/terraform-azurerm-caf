variable name {
  description = "(Required) Specifies the name of the HTTP Action to be created within the Logic App Workflow"
}

variable logic_app_id {
  description = "(Required) Specifies the ID of the Logic App Workflow"
}

variable method {
  description = "(Required) Specifies the HTTP Method which should be used for this HTTP Action"
}

variable uri {
  description = "(Required) Specifies the URI which will be called when this HTTP Action is triggered"
}

variable body {
  description = "(Optional) Specifies the HTTP Body that should be sent to the uri when this HTTP Action is triggered"
}

variable headers {
  description = "(Optional) Specifies a Map of Key-Value Pairs that should be sent to the uri when this HTTP Action is triggered"
}

variable run_after {
  description = "(Optional) Specifies the place of the HTTP Action in the Logic App Workflow"
}