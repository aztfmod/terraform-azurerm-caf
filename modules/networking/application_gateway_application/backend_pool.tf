
resource "null_resource" "set_backend_pools" {
  for_each = try(var.settings.backend_pools, {})

  triggers = {
    backend_pool = jsonencode(each.value)
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/set_resource.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE                 = "BACKENDPOOL"
      RG_NAME                  = var.application_gateway.resource_group_name
      APPLICATION_GATEWAY_NAME = var.application_gateway.name
      APPLICATION_GATEWAY_ID   = var.application_gateway.id
      NAME                     = each.value.name
      ADDRESS_POOL             = local.backend_pools[each.key].address_pools
    }
  }
}

resource "null_resource" "delete_backend_pool" {
  for_each = try(var.settings.backend_pools, {})

  triggers = {
    backend_pool_name        = each.value.name
    resource_group_name      = var.application_gateway.resource_group_name
    application_gateway_name = var.application_gateway.name
    application_gateway_id   = var.application_gateway.id
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/delete_resource.sh", path.module)
    when        = destroy
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE                 = "BACKENDPOOL"
      NAME                     = self.triggers.backend_pool_name
      RG_NAME                  = self.triggers.resource_group_name
      APPLICATION_GATEWAY_NAME = self.triggers.application_gateway_name
      APPLICATION_GATEWAY_ID   = self.triggers.application_gateway_id
    }
  }
}