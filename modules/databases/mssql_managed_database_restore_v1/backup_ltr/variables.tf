variable "server_id" {
  default = null
}
variable "db_id" {}
variable "settings" {
  default = {}
}
variable "inherit_ltr" {
  type    = bool
  default = false

}

