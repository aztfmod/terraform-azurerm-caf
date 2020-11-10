

variable tags {
  description = "(Required) map of tags for the deployment"
}

variable app_service_environment_id {
  description = "(Required) ASE Id for App Service Plan Hosting Environment"
  default     = null
}

variable resource_group_name {}

variable location {}

variable settings {}

variable kind {
  description = "(Optional) The kind of the App Service Plan to create. Possible values are Windows (also available as App), Linux, elastic (for Premium Consumption) and FunctionApp (for a Consumption Plan). Defaults to Windows. Changing this forces a new resource to be created."
  default     = "Windows"
}

variable global_settings {}

variable base_tags {}