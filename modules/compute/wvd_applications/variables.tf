variable "settings" {
  type = any
}
variable "global_settings" {
  type = any

}

variable "application_group_id" {
  type    = any
  default = {}
}

variable "diagnostic_profiles" {
  type    = any
  default = {}
}
variable "diagnostics" {
  type = any
}
