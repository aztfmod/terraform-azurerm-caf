variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  type        = any
  description = "Settings object (see module README.md)."
}
variable "logic_app_id" {
  description = "(Required) Specifies the ID of the Logic App Workflow"
}
