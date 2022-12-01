variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "settings" {
  type = any
}
variable "synapse_workspace_id" {}
variable "tags" {
  type        = map(any)
  description = "(Required) Map of tags to be applied to the resource"
}

