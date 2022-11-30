variable "name" {
  default = null
}
variable "display_name" {
  default = null
}
variable "settings" {
  type    = any
  default = null
}
variable "log_analytics_workspace_id" {
  default = null
}
variable "order" {
  default = null
}
variable "enabled" {
  default = null
}
variable "expiration" {
  default = null
}
variable "combined_objects_logic_app_workflow" {
  default = null
}
variable "client_config" {
  type    = map(any)
  default = null
}
