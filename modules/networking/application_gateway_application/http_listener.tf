
resource "null_resource" "set_http_listener" {
  depends_on = [time_sleep.set_http_settings, time_sleep.set_backend_pools, time_sleep.set_ssl_cert, time_sleep.set_root_cert]

  for_each = try(var.settings.http_listeners, {})

  triggers = {
    http_listener = jsonencode(each.value)
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/set_resource.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE                    = "HTTPLISTENER"
      RG_NAME                     = var.application_gateway.resource_group_name
      APPLICATION_GATEWAY_NAME    = var.application_gateway.name
      NAME                        = each.value.name
      PORT                        = var.application_gateway.frontend_ports[each.value.front_end_port_key].name
      PUBLIC_IP                   = try(var.application_gateway.frontend_ip_configurations[each.value.front_end_ip_configuration_key].name, null)
      HOST_NAME                   = try(each.value.host_name, null)
      HOST_NAMES                  = try(each.value.host_names, null)
      SSL_CERT                    = try(var.settings.ssl_certs[each.value.ssl_cert_key].name, null) //TODO
      WAF_POLICY                  = try(each.value.waf_policy, null) //TODO
    }
  }
}

resource "time_sleep" "set_http_listener" {
  depends_on = [null_resource.set_http_listener]

  create_duration = "10s"
}

resource "null_resource" "delete_http_listener" {
  depends_on = [time_sleep.delete_http_settings, time_sleep.delete_backend_pool, time_sleep.delete_ssl_cert, time_sleep.delete_root_cert]

  for_each = try(var.settings.http_listeners, {})

  triggers = {
    http_listener_name       = each.value.name
    resource_group_name      = var.application_gateway.resource_group_name
    application_gateway_name = var.application_gateway.name
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/delete_resource.sh", path.module)
    when        = destroy
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE                 = "HTTPLISTENER"
      NAME                     = self.triggers.http_listener_name
      RG_NAME                  = self.triggers.resource_group_name
      APPLICATION_GATEWAY_NAME = self.triggers.application_gateway_name
    }
  }
}

resource "time_sleep" "delete_http_listener" {
  depends_on = [null_resource.delete_http_listener]

  create_duration = "10s"
}