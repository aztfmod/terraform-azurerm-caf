variable prefix {
  description = "Prefixes to be used in the name of the App registration"
}

variable keyvaults {
  description = "Map of deployed azurerm_key_vault"
}

variable aad_apps {
  description = "Map of aad_app objects to create Azure Active Directory applications"
}

variable aad_api_permissions {
  description = "Map of aad_api_permission objects to provide API access to an Azure Active Directory application"
}

variable aad_app {
  description = "Object to create Azure Active Directory application"
  type = object({
    convention              = string
    useprefix               = bool
    application_name        = string
    password_expire_in_days = number

    keyvault = object({
      keyvault_key            = string
      key_permissions         = list(string)
      secret_permissions      = list(string)
      storage_permissions     = list(string)
      certificate_permissions = list(string)
    })

  })

  default = {
    convention              = "cafrandom"
    useprefix               = false
    application_name        = null
    password_expire_in_days = 180
    keyvault                = null
  }
}

variable aad_api_permission {
  description = "Object to provide API access to an Azure Active Directory application"
  type = map(object({
    resource_app_id = string
    rsource_access = map(object({
      id   = string
      type = string
    }))
  }))

  default = {}
}