
resource "null_resource" "set_url_path_map" {
  depends_on = [null_resource.set_http_settings, null_resource.set_backend_pools, null_resource.set_http_listener, null_resource.set_ssl_cert, null_resource.set_root_cert, null_resource.set_rewrite_rule_set, null_resource.set_rewrite_rule, null_resource.set_rewrite_rule_condition]

  for_each = try(var.settings.url_path_maps, {})

  triggers = {
    url_path_map = jsonencode(each.value)
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/set_resource.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE                 = "PATHMAP"
      RG_NAME                  = var.application_gateway.resource_group_name
      APPLICATION_GATEWAY_NAME = var.application_gateway.name
      APPLICATION_GATEWAY_ID   = var.application_gateway.id
      NAME                     = each.value.name
      PATHS                    = each.value.paths
      DEFAULT_ADDRESS_POOL     = try(var.settings.backend_pools[each.value.default_backend_pool_key].name, var.settings.backend_pools[each.value.backend_pool_key].name)
      ADDRESS_POOL             = var.settings.backend_pools[each.value.backend_pool_key].name
      DEFAULT_HTTP_SETTINGS    = try(var.settings.http_settings[each.value.default_http_settings_key].name, var.settings.http_settings[each.value.http_settings_key].name)
      HTTP_SETTINGS            = var.settings.http_settings[each.value.http_settings_key].name
      DEFAULT_REDIRECT_CONFIG  = try(each.value.default_redirect_config, each.value.redirect_config, null)
      REDIRECT_CONFIG          = try(each.value.redirect_config, null)
      DEFAULT_REWRITE_RULE_SET = try(var.settings.rewrite_rule_sets[each.value.default_rewrite_rule_set_key].name, var.settings.rewrite_rule_sets[each.value.rewrite_rule_set_key].name, null)
      REWRITE_RULE_SET         = try(var.settings.rewrite_rule_sets[each.value.rewrite_rule_set_key].name, null)
      RULE_NAME                = try(each.value.rule_name, null)
      WAF_POLICY               = try(each.value.waf_policy, null)
    }
  }
}

resource "null_resource" "delete_url_path_map" {
  depends_on = [null_resource.delete_http_settings, null_resource.delete_backend_pool, null_resource.delete_http_listener, null_resource.delete_ssl_cert, null_resource.delete_root_cert, null_resource.delete_rewrite_rule_set, null_resource.delete_rewrite_rule, null_resource.delete_rewrite_rule_condition]

  for_each = try(var.settings.url_path_maps, {})

  triggers = {
    url_path_map_name        = each.value.name
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
      RESOURCE                 = "PATHMAP"
      NAME                     = self.triggers.url_path_map_name
      RG_NAME                  = self.triggers.resource_group_name
      APPLICATION_GATEWAY_NAME = self.triggers.application_gateway_name
      APPLICATION_GATEWAY_ID   = self.triggers.application_gateway_id
    }
  }
}