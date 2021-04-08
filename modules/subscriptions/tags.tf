resource "null_resource" "tags" {
  depends_on = [null_resource.refresh_access_token]

  count = try(var.settings.tags, null) == null ? 0 : 1

  triggers = {
    subscription_id = try(azurerm_subscription.sub.0.subscription_id, var.settings.subscription_id)
    tags = jsonencode(
      {
        properties = {
          tags = var.settings.tags
        }
      }
    )
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/tags.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      METHOD          = "PUT"
      SUBSCRIPTION_ID = try(azurerm_subscription.sub.0.subscription_id, var.settings.subscription_id)
      TAGS = jsonencode(
        {
          properties = {
            tags = var.settings.tags
          }
        }
      )
    }
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/tags.sh", path.module)
    when        = destroy
    interpreter = ["/bin/bash"]
    on_failure  = continue

    environment = {
      METHOD          = "PUT"
      SUBSCRIPTION_ID = self.triggers.subscription_id
      TAGS = jsonencode(
        {
          properties = {
            tags = {}
          }
        }
      )
    }
  }

}
