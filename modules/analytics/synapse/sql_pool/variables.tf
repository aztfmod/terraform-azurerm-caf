variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "settings" {}
variable "synapse_workspace_id" {}
variable "tags" {
  description = "(Required) Map of tags to be applied to the resource"
  type        = map(any)
}

