
resource "null_resource" "set_redirect_configurations" {
  depends_on = [null_resource.set_http_listener]

  for_each = try(var.settings.redirect_configurations, {})

  triggers = {
    redirect_configurations = jsonencode(each.value)
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/set_resource.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE                 = "REDIRECTCONFIG"
      RG_NAME                  = var.application_gateway.resource_group_name
      APPLICATION_GATEWAY_NAME = var.application_gateway.name
      APPLICATION_GATEWAY_ID   = var.application_gateway.id
      NAME                     = each.value.name
      REDIRECT_TYPE            = each.value.redirect_type
      TARGET_LISTENER_NAME     = try(each.value.target_listener_name, null)
      TARGET_URL               = try(each.value.target_url, null)
      INCLUDE_PATH             = each.value.include_path
      INCLUDE_QUERY_STRING     = each.value.include_query_string
      RULE_TYPE                = try(each.value.rule_type, null)
    }
  }
}

resource "null_resource" "delete_redirect_configurations" {
  depends_on = [null_resource.delete_http_settings, null_resource.delete_backend_pool, null_resource.delete_http_listener, null_resource.delete_ssl_cert, null_resource.delete_root_cert, null_resource.delete_rewrite_rule_set, null_resource.delete_rewrite_rule, null_resource.delete_rewrite_rule_condition, null_resource.delete_url_path_map, null_resource.delete_url_path_rule]

  for_each = try(var.settings.redirect_configurations, {})

  triggers = {
    redirect_configurations_name = each.value.name
    resource_group_name          = var.application_gateway.resource_group_name
    application_gateway_name     = var.application_gateway.name
    application_gateway_id       = var.application_gateway.id
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/delete_resource.sh", path.module)
    when        = destroy
    interpreter = ["/bin/bash"]
    on_failure  = continue

    environment = {
      RESOURCE                 = "REDIRECTCONFIG"
      NAME                     = self.triggers.redirect_configurations_name
      RG_NAME                  = self.triggers.resource_group_name
      APPLICATION_GATEWAY_NAME = self.triggers.application_gateway_name
      APPLICATION_GATEWAY_ID   = self.triggers.application_gateway_id
    }
  }
}