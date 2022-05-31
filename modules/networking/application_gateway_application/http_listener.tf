data "azurerm_key_vault_certificate" "http_listener_manual_certs" {
  for_each = {
    for key, value in try(var.settings.http_listeners, {}) : key => value
    if can(value.keyvault_certificate.certificate_name)
  }
  name         = each.value.keyvault_certificate.certificate_name
  key_vault_id = can(each.value.keyvault_certificate.keyvault_id) ? each.value.keyvault_certificate.keyvault_id : var.keyvaults[try(each.value.keyvault_certificate.lz_key, var.client_config.landingzone_key)][each.value.keyvault_certificate.keyvault_key].id
}

resource "null_resource" "set_http_listener" {
  depends_on = [null_resource.set_http_settings, null_resource.set_backend_pools, null_resource.set_ssl_cert, null_resource.set_root_cert]

  for_each = try(var.settings.http_listeners, {})

  triggers = {
    http_listener = jsonencode(each.value)
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/set_resource.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE                 = "HTTPLISTENER"
      RG_NAME                  = var.application_gateway.resource_group_name
      APPLICATION_GATEWAY_NAME = var.application_gateway.name
      APPLICATION_GATEWAY_ID   = var.application_gateway.id
      NAME                     = each.value.name
      PORT                     = var.application_gateway.frontend_ports[each.value.front_end_port_key].name
      PUBLIC_IP                = try(var.application_gateway.frontend_ip_configurations[each.value.front_end_ip_configuration_key].name, null)
      HOST_NAME                = try(each.value.host_name, null)
      HOST_NAMES               = try(each.value.host_names, null)
      SSL_CERT                 = can(each.value.keyvault_certificate.certificate_name) || can(each.value.ssl_cert_key) == false ? try(data.azurerm_key_vault_certificate.http_listener_manual_certs[each.key].id, null) : var.settings.ssl_certs[each.value.ssl_cert_key].name
      WAF_POLICY               = try(var.application_gateway_waf_policies[try(each.value.waf_policy.lz_key, var.client_config.landingzone_key)][each.value.waf_policy.key].id, null)
    }
  }
}

resource "null_resource" "delete_http_listener" {
  depends_on = [null_resource.delete_http_settings, null_resource.delete_backend_pool, null_resource.delete_ssl_cert, null_resource.delete_root_cert]

  for_each = try(var.settings.http_listeners, {})

  triggers = {
    http_listener_name       = each.value.name
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
      RESOURCE                 = "HTTPLISTENER"
      NAME                     = self.triggers.http_listener_name
      RG_NAME                  = self.triggers.resource_group_name
      APPLICATION_GATEWAY_NAME = self.triggers.application_gateway_name
      APPLICATION_GATEWAY_ID   = self.triggers.application_gateway_id
    }
  }
}