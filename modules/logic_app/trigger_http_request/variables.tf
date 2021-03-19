variable name {
  description = "(Required) Specifies the name of the HTTP Request Trigger to be created within the Logic App Workflow"
}

variable logic_app_id {
  description = "(Required) Specifies the ID of the Logic App Workflow"
}

variable schema {
  description = "(Required) A JSON Blob defining the Schema of the incoming request"
}

variable method {
  description = "(Optional) Specifies the HTTP Method which the request be using"
}

variable relative_path {
  description = "(Optional) Specifies the Relative Path used for this Request"
}