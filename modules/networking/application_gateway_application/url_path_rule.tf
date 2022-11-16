
resource "null_resource" "set_url_path_rule" {
  depends_on = [null_resource.set_http_settings, null_resource.set_backend_pools, null_resource.set_http_listener, null_resource.set_ssl_cert, null_resource.set_root_cert, null_resource.set_url_path_map]

  for_each = try(var.settings.url_path_rules, {})

  triggers = {
    url_path_rule = jsonencode(each.value)
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/set_resource.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE                 = "PATHRULE"
      RG_NAME                  = var.application_gateway.resource_group_name
      APPLICATION_GATEWAY_NAME = var.application_gateway.name
      APPLICATION_GATEWAY_ID   = var.application_gateway.id
      NAME                     = each.value.name
      PATHS                    = each.value.paths
      PATHMAPNAME              = var.settings.url_path_maps[each.value.url_path_map_key].name
      ADDRESS_POOL             = try(var.settings.backend_pools[each.value.backend_pool_key].name, null)
      HTTP_SETTINGS            = try(var.settings.http_settings[each.value.http_settings_key].name, null)
      REDIRECT_CONFIG          = try(each.value.redirect_config, null)
      REWRITE_RULE_SET         = try(each.value.rewrite_rule_set, null)
      WAF_POLICY               = try(each.value.waf_policy, null)
    }
  }
}

resource "null_resource" "delete_url_path_rule" {
  depends_on = [null_resource.delete_http_settings, null_resource.delete_backend_pool, null_resource.delete_http_listener, null_resource.delete_ssl_cert, null_resource.delete_root_cert, null_resource.delete_url_path_map]

  for_each = try(var.settings.url_path_rules, {})

  triggers = {
    url_path_rule_name       = each.value.name
    resource_group_name      = var.application_gateway.resource_group_name
    application_gateway_name = var.application_gateway.name
    path_map_name            = var.settings.url_path_maps[each.value.url_path_map_key].name
    application_gateway_id   = var.application_gateway.id
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/delete_resource.sh", path.module)
    when        = destroy
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE                 = "PATHRULE"
      NAME                     = self.triggers.url_path_rule_name
      RG_NAME                  = self.triggers.resource_group_name
      APPLICATION_GATEWAY_NAME = self.triggers.application_gateway_name
      PATHMAPNAME              = self.triggers.path_map_name
      APPLICATION_GATEWAY_ID   = self.triggers.application_gateway_id
    }
  }
}