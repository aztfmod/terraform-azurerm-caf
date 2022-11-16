locals {
  api_version                 = "2019-10-01-preview"
  microsoft_resource_endpoint = var.cloud.resourceManager
}

resource "null_resource" "subscription_creation_role" {
  triggers = {
    url = format("%s%s/billingRoleAssignments/%s?api-version=%s&useCosmos=true", local.microsoft_resource_endpoint, var.billing_scope_id, var.principal_id, local.api_version)
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
