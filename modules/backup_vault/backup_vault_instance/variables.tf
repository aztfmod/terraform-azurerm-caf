variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
  
#   validation {
#     condition     = contains(["southcentralus", "centralus"], var.location)
#     error_message = "Allowed values are southcentralus, centralus."
#   }
}
variable "settings" {}
variable "vault_id" {}
variable "storage_account_id" {
  description = "The ID of the Storage Account to be used by the backup vault instance."
}
variable "backup_policy_id" {
  description = "The ID of the backup vault policy to be used by the backup vault instance"
}
