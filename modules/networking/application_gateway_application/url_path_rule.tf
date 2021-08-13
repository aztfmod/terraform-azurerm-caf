
resource "null_resource" "set_url_path_rule" {
  depends_on = [time_sleep.set_http_settings, time_sleep.set_backend_pools, time_sleep.set_http_listener, time_sleep.set_ssl_cert, time_sleep.set_root_cert, time_sleep.set_url_path_map]

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
      NAME                     = each.value.name
      PATHS                    = each.value.paths
      PATHMAPNAME              = try(var.settings.url_path_maps[each.value.url_path_map_key].name, null)
      ADDRESS_POOL             = try(var.settings.backend_pools[each.value.backend_pool_key].name, null)
      HTTP_SETTINGS            = try(var.settings.http_settings[each.value.http_settings_key].name, null)
      REDIRECT_CONFIG          = try(each.value.redirect_config, null)
      REWRITE_RULE_SET         = try(each.value.rewrite_rule_set, null)
      WAF_POLICY               = try(each.value.waf_policy, null)
    }
  }
}

resource "time_sleep" "set_url_path_rule" {
  depends_on = [null_resource.set_url_path_rule]

  create_duration = "10s"
}

resource "null_resource" "delete_url_path_rule" {
  depends_on = [time_sleep.delete_http_settings, time_sleep.delete_backend_pool, time_sleep.delete_http_listener, time_sleep.delete_ssl_cert, time_sleep.delete_url_path_map]

  for_each = try(var.settings.url_path_rules, {})

  triggers = {
    url_path_rule_name       = each.value.name
    resource_group_name      = var.application_gateway.resource_group_name
    application_gateway_name = var.application_gateway.name
    path_map_name            = each.value.path_map_name
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
    }
  }
}

resource "time_sleep" "delete_url_path_rule" {
  depends_on = [null_resource.delete_url_path_rule]

  create_duration = "10s"
}