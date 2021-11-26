
data "azurerm_key_vault_certificate" "manual_certs" {
  for_each = {
    for key, value in try(var.settings.ssl_certs, {}) : key => value
    if try(value.keyvault.certificate_name, null) != null
  }
  name         = each.value.keyvault.certificate_name
  key_vault_id = var.keyvaults[try(each.value.keyvault.lz_key, var.client_config.landingzone_key)][each.value.keyvault.key].id
}

resource "null_resource" "set_ssl_cert" {
  depends_on = [null_resource.set_backend_pools]

  for_each = try(var.settings.ssl_certs, {})

  triggers = {
    ssl_cert = jsonencode(each.value)
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/set_resource.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE                 = "SSLCERT"
      RG_NAME                  = var.application_gateway.resource_group_name
      APPLICATION_GATEWAY_NAME = var.application_gateway.name
      APPLICATION_GATEWAY_ID   = var.application_gateway.id
      NAME                     = each.value.name
      CERT_FILE                = try(each.value.cert_file, null)
      CERT_PASSWORD            = try(each.value.cert_password, null)
      KEY_VAULT_SECRET_ID      = try(data.azurerm_key_vault_certificate.manual_certs[each.key].secret_id, var.keyvault_certificates[try(each.value.keyvault.lz_key, var.client_config.landingzone_key)][each.value.keyvault.certificate_key].secret_id, var.keyvault_certificate_requests[try(each.value.keyvault.lz_key, var.client_config.landingzone_key)][each.value.certificate_request_key].secret_id, null)
    }
  }
}

resource "null_resource" "delete_ssl_cert" {
  depends_on = [null_resource.delete_backend_pool]

  for_each = try(var.settings.ssl_certs, {})

  triggers = {
    ssl_cert_name            = each.value.name
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
      RESOURCE                 = "SSLCERT"
      NAME                     = self.triggers.ssl_cert_name
      RG_NAME                  = self.triggers.resource_group_name
      APPLICATION_GATEWAY_NAME = self.triggers.application_gateway_name
      APPLICATION_GATEWAY_ID   = self.triggers.application_gateway_id
    }
  }
}