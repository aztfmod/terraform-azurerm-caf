variable "name" {
  description = "(Required) Name for the automation account"
}

variable "location" {
  description = "(Required) Location for the automation acount"
}

variable "tags" {
  description = "(Required) Tags for the automation account"
}  

variable "la_workspace_id" {
  description = "(Required) Log Analytics Repository"
}
variable "diagnostics_map" {
 description = "(Required) Map with the diagnostics settings."
}

variable "diagnostics_settings" {
 description = "(Required) Map with the diagnostics settings"
}

##newstyle

variable settings {}
variable global_settings {}
variable resource_group_name {}
