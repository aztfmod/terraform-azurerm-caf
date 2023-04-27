variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "settings" {}
variable "managed_instance_id" {
  description = "(Required) The id of the SQL Managed Instance which will be replicated using a SQL Instance Failover Group. Changing this forces a new SQL Instance Failover Group to be created."
  type        = string
}
variable "partner_managed_instance_id" {
  description = "(Required) ID of the SQL Managed Instance which will be replicated to. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "(Required) The Azure Region where the SQL Instance Failover Group exists. Changing this forces a new resource to be created."
  type        = string
}
