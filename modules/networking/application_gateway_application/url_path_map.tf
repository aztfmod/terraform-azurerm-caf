
resource "null_resource" "set_url_path_map" {
  depends_on = [time_sleep.set_http_settings, time_sleep.set_backend_pools, time_sleep.set_http_listener, time_sleep.set_ssl_cert, time_sleep.set_root_cert]

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
      NAME                     = each.value.name
      PATHS                    = each.value.paths
      ADDRESS_POOL             = try(var.settings.backend_pools[each.value.backend_pool_key].name, null)
      HTTP_SETTINGS            = try(var.settings.http_settings[each.value.http_settings_key].name, null)
      REDIRECT_CONFIG          = try(each.value.redirect_config, null)
      REWRITE_RULE_SET         = try(each.value.rewrite_rule_set, null)
      RULE_NAME                = try(each.value.rule_name, null)
      WAF_POLICY               = try(each.value.waf_policy, null)
    }
  }
}

resource "time_sleep" "set_url_path_map" {
  depends_on = [null_resource.set_url_path_map]

  create_duration = "10s"
}

resource "null_resource" "delete_url_path_map" {
  depends_on = [time_sleep.delete_http_settings, time_sleep.delete_backend_pool, time_sleep.delete_http_listener, time_sleep.delete_ssl_cert]

  for_each = try(var.settings.url_path_maps, {})

  triggers = {
    url_path_map_name       = each.value.name
    resource_group_name      = var.application_gateway.resource_group_name
    application_gateway_name = var.application_gateway.name
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
    }
  }
}

resource "time_sleep" "delete_url_path_map" {
  depends_on = [null_resource.delete_url_path_map]

  create_duration = "10s"
}