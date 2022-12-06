variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "settings" {
  type = any
}
variable "synapse_workspace_id" {
  type = any
}
variable "tags" {
  type        = any
  description = "(Required) Map of tags to be applied to the resource"
}

