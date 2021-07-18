
resource "null_resource" "set_backend_pools" {
  for_each = var.settings.backend_pools

  triggers = {
    backend_pool = jsonencode(each.value)
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/set_backend_pool.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RG_NAME                  = var.application_gateway.resource_group_name
      APPLICATION_GATEWAY_NAME = var.application_gateway.name
      NAME                     = each.value.name
      ADDRESS_POOL             = local.backend_pools[each.key].address_pools
    }
  }
}

resource "null_resource" "delete_backend_pool" {
  for_each = var.settings.backend_pools

  triggers = {
    backend_pool_name        = each.value.name
    resource_group_name      = var.application_gateway.resource_group_name
    application_gateway_name = var.application_gateway.name
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/delete_backend_pool.sh", path.module)
    when        = destroy
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      NAME                     = self.triggers.backend_pool_name
      RG_NAME                  = self.triggers.resource_group_name
      APPLICATION_GATEWAY_NAME = self.triggers.application_gateway_name
    }
  }
}