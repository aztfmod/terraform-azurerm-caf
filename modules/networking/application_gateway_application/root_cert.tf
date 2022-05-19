
data "azurerm_key_vault_certificate" "root_certs" {
  for_each = {
    for key, value in try(var.settings.trusted_root_certificates, {}) : key => value
    if try(value.keyvault.certificate_name, null) != null
  }
  name         = each.value.keyvault.certificate_name
  key_vault_id = var.keyvaults[try(each.value.keyvault.lz_key, var.client_config.landingzone_key)][each.value.keyvault.key].id
}

resource "null_resource" "set_root_cert" {
  depends_on = [null_resource.set_backend_pools, null_resource.set_ssl_cert]

  for_each = try(var.settings.trusted_root_certificates, {})

  triggers = {
    root_cert = jsonencode(each.value)
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/set_resource.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      RESOURCE                 = "ROOTCERT"
      RG_NAME                  = var.application_gateway.resource_group_name
      APPLICATION_GATEWAY_NAME = var.application_gateway.name
      APPLICATION_GATEWAY_ID   = var.application_gateway.id
      NAME                     = each.value.name
      CERT_FILE                = try(each.value.cert_file, null)
      KEY_VAULT_SECRET_ID      = can(each.value.keyvault.secret_id) || can(each.value.keyvault.certificate_name) || can(each.value.cert_file) ? try(each.value.keyvault.secret_id, data.azurerm_key_vault_certificate.root_certs[each.key].secret_id, null) : each.value.keyvault.secret_id
    }
  }
}

resource "null_resource" "delete_root_cert" {
  depends_on = [null_resource.delete_backend_pool, null_resource.delete_ssl_cert]

  for_each = try(var.settings.trusted_root_certificates, {})

  triggers = {
    root_cert_name           = each.value.name
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
      RESOURCE                 = "ROOTCERT"
      NAME                     = self.triggers.root_cert_name
      RG_NAME                  = self.triggers.resource_group_name
      APPLICATION_GATEWAY_NAME = self.triggers.application_gateway_name
      APPLICATION_GATEWAY_ID   = self.triggers.application_gateway_id
    }
  }
}