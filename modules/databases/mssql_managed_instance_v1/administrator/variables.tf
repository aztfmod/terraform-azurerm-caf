variable "group_id" {
  default = null
  type    = string
}
variable "managed_instance_id" {
  description = "(Required) The ID of the Azure SQL Managed Instance for which to set the administrator. Changing this forces a new resource to be created."
  type        = string
}

variable "tenant_id" {
  description = "(Required) The Azure Active Directory Tenant ID."
  type        = string
}

variable "settings" {
  description = "(Optional) A settings block as defined below."
  type = object({
    login_username = string
    sid            = optional(string)
    tenant_id      = optional(string)
  })

}
variable "aad_only_auth" {
  default  = false
  nullable = false
}