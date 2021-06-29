
resource "azuread_service_principal" "app" {
  application_id               = var.application_id
  app_role_assignment_required = try(var.settings.app_role_assignment_required, false)

  lifecycle {
    ignore_changes = [application_id]
  }
}

resource "null_resource" "propagate_to_azuread" {
  depends_on = [azuread_service_principal.app]

  provisioner "local-exec" {
    command    = "/bin/bash -c '/usr/bin/sleep 30'"
    on_failure = fail
  }
}