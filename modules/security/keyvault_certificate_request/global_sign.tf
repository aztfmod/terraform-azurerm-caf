data "azurerm_key_vault_secret" "password" {
  count        = lower(var.settings.certificate_policy.issuer_key_or_name) == "self" ? 0 : 1
  name         = var.certificate_issuers[var.settings.certificate_policy.issuer_key_or_name].cert_password_key
  key_vault_id = var.keyvault_id
}

locals {
  soap_get_certificate_orders = lower(var.settings.certificate_policy.issuer_key_or_name) == "self" ? null : templatefile(
    format("%s/GlobalSign_GetCertificateOrders.tpl", path.module),
    {
      UserName = var.certificate_issuers[var.settings.certificate_policy.issuer_key_or_name].account_id,
      Password = data.azurerm_key_vault_secret.password[0].value,
      FQDN     = regex("[^CN=]+", var.settings.certificate_policy.x509_certificate_properties.subject) # regex("[^CN=]+", "CN=crm.test.com") ==> crm.test.com
    }
  )

  soap_cancel_order = lower(var.settings.certificate_policy.issuer_key_or_name) == "self" ? null : templatefile(
    format("%s/GlobalSign_cancel_order.tpl", path.module),
    {
      UserName = var.certificate_issuers[var.settings.certificate_policy.issuer_key_or_name].account_id,
      Password = data.azurerm_key_vault_secret.password[0].value
    }
  )
}

# When canceled within 7 days, the certificate is not invoiced
resource "null_resource" "cancel_order_global_sign" {
  count = try(var.certificate_issuers[var.settings.certificate_policy.issuer_key_or_name].provider_name, null) == "GlobalSign" ? 1 : 0

  triggers = {
    SOAP_GET_ORDERS   = local.soap_get_certificate_orders
    SOAP_CANCEL_ORDER = local.soap_cancel_order
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/GlobalSign_cancel_orders.sh", path.module)
    when        = destroy
    interpreter = ["/bin/bash"]
    on_failure  = continue

    environment = {
      SOAP_GET_ORDERS       = self.triggers.SOAP_GET_ORDERS
      SOAP_CANCEL_ORDER_TPL = self.triggers.SOAP_CANCEL_ORDER
    }
  }
  lifecycle {
    ignore_changes = [
      triggers
    ]
  }
}
