variable "settings" {
  type = any
}
variable "global_settings" {
  type = any

}

variable "application_group_id" {
  default = {}
}

variable "diagnostic_profiles" {
  type    = map(any)
  default = {}
}
variable "diagnostics" {
  type = map(any)
}
