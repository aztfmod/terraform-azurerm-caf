
output tenant_id {
  value     = var.client_config.tenant_id
  sensitive = true
}

output azuread_application {
  value = {
    id             = azuread_application.app.id
    object_id      = azuread_application.app.object_id
    application_id = azuread_application.app.application_id
    name           = azuread_application.app.name
  }
  sensitive = true
}

output azuread_service_principal {
  value = {
    id        = azuread_service_principal.app.id
    object_id = azuread_service_principal.app.object_id
  }
  sensitive = true
}

output keyvault {
  value = try(module.keyvault_secret_policy.0, null)
}

output rbac_id {
  value       = azuread_service_principal.app.object_id
  description = "This attribute is used to set the role assignment"
}
