variable "global_settings" {
  default = {}
}

variable "resource_groups" {
  default = null
}

variable "diagnostic_event_hub_namespaces" {
  default = {}
}

variable "diagnostics_definition" {
  default = {}
}

variable "diagnostics_destinations" {
  default = {}
}

variable "tags" {
  default = null
  type    = map(any)
}

variable "var_folder_path" {
  default = {}
}