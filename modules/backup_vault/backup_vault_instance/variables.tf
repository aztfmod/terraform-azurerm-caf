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
variable "storage_account_id" {}
variable "backup_policy_id" {}
