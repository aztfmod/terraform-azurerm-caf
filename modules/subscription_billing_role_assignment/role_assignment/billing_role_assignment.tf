locals {
  api_version = "2019-10-01-preview"
}

resource "null_resource" "subscription_creation_role" {
  triggers = {
    url = format("https://management.azure.com%s/billingRoleAssignments/%s?api-version=%s&useCosmos=true", var.billing_scope_id, var.principal_id, local.api_version)
    properties = jsonencode(
      {
        properties = {
          principalId       = var.principal_id
          principalTenantId = var.tenant_id
          roleDefinitionId  = var.role_definition_id
        }
      }
    )
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/billing_role_assignment.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      METHOD     = "PUT"
      URL        = self.triggers.url
      PROPERTIES = self.triggers.properties
    }
  }

}
