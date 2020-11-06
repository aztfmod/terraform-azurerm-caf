variable nw_config {
  description = "(Optional) Configuration settings for network watcher."
}

variable nsg {
  description = "(Required) NSG list of objects"
}

variable rg {}
variable diagnostics_map {}
variable log_analytics_workspace {}
variable location {}

variable netwatcher {
  description = "(Optional) is a map with two attributes: name, rg who describes the name and rg where the netwatcher was already deployed"
  default     = {}
}

variable tags {}
variable base_tags {}
