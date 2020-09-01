variable keyvault_id {}

variable access_policies {
  validation {
    condition     = length(var.access_policies) <= 16
    error_message = "A maximun of 16 access policies can be set."
  }
}

variable tenant_id {}

variable logged_user_objectId {
  default = null
}
variable logged_aad_app_objectId {
  default = null
}
variable azuread_groups {
  default = {}
}
variable azuread_apps {
  default = {}
}
