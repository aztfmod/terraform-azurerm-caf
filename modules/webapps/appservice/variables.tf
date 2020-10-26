

variable tags {
  description = "(Required) map of tags for the deployment"
}

variable name {
  description = "(Required) Name of the App Service"
}

variable location {
  description = "(Required) Resource Location"
}

variable resource_group_name {
  description = "(Required) Resource group of the App Service"
}

variable app_service_plan_id {
}

variable identity {
  default = null
}

variable connection_strings {
  default = {}
}

variable app_settings {
  default = null
}

variable slots {
  default = {}
}

variable application_insight {
  default = null
}

variable settings {}

variable global_settings {}

variable base_tags {}