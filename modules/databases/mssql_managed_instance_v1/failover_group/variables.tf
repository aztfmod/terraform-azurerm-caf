variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "settings" {}
variable "managed_instance" {
  description = "(Required) The primary SQL Managed Instance object which will be replicated using a SQL Instance Failover Group. Changing this forces a new SQL Instance Failover Group to be created."
}
variable "partner_managed_instance" {
  description = "(Required) The SQL Managed Instance object which will be replicated to. Changing this forces a new resource to be created."
}