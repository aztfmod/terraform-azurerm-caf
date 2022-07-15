variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable "settings" {}
variable "vault_id" {}
variable "disk_id" {
  description = "Identifier of the disk to be used."
  type        = string
}
variable "snapshot_resource_group_name" {
  description = "The name of the Resource Group where snapshots are stored."
  type        = string
}
variable "backup_policy_id" {
  description = "The ID of the backup vault policy to be used."
  type        = string
}
