
variable resource_group_name {
  description = "(Required) Name of the resource group where to create the resource. Changing this forces a new resource to be created. "
  type        = string
}

variable location {
  description = "(Required) Specifies the Azure location to deploy the resource. Changing this forces a new resource to be created."
  type        = string
}

variable tags {
  description = "(Required) map of tags for the deployment"
}

# variable "diagnostics_map" {
#   description = "(Required) contains the SA and EH details for operations diagnostics"
# }

# variable "log_analytics_workspace" {
#   description = "(Required) contains the log analytics workspace details for operations diagnostics"
# }

# variable "diagnostics_settings" {
#   description = "(Required) configuration object describing the diagnostics"
# }

variable diagnostics {
  description = "(Required) Diagnostics object with the definitions and destination services"
}

variable networking_object {
  description = "(Required) configuration object describing the networking configuration, as described in README"
}

variable network_security_group_definition {

}

variable convention {
  description = "(Required) Naming convention method to use"
}

variable netwatcher {
  description = "(Optional) is a map with two attributes: name, rg who describes the name and rg where the netwatcher was already deployed"
  default     = {}
}

variable ddos_id {
  description = "(Optional) ID of the DDoS protection plan if exists"
  default     = ""
}

variable prefix {
  description = "(Optional) You can use a prefix to the name of the resource"
  type        = string
  default     = ""
}

variable postfix {
  description = "(Optional) You can use a postfix to the name of the resource"
  type        = string
  default     = ""
}

variable max_length {
  description = "(Optional) You can speficy a maximum length to the name of the resource"
  type        = string
  default     = "60"
}
