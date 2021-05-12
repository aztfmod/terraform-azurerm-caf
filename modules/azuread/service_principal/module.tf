
resource "azuread_service_principal" "app" {
  application_id               = var.application_id
  app_role_assignment_required = try(var.settings.app_role_assignment_required, false)
}
