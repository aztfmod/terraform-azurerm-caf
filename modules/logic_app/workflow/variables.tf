variable tags {
  description = "(Required) map of tags for the deployment"
}

variable name {
  description = "(Required) Name of the Logic App"
}

variable location {
  description = "(Required) Resource Location"
}

variable resource_group_name {
  description = "(Required) Resource group of the Logic App"
}

variable integration_service_environment_id {
}

variable logic_app_integration_account_id {
}

variable workflow_schema {
}

variable workflow_version {
}

variable parameters {
  default = {}
}

variable application_insight {
  default = null
}

variable global_settings {}

variable base_tags {}