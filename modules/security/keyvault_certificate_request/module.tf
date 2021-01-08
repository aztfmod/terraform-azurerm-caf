resource "azurerm_key_vault_certificate" "csr" {
  name         = var.settings.name
  key_vault_id = var.keyvault_id

  certificate_policy {
    issuer_parameters {
      name = try(var.certificate_issuers[var.settings.certificate_policy.issuer_key_or_name].name, var.settings.certificate_policy.issuer_key_or_name)
    }
    key_properties {
      exportable = var.settings.certificate_policy.exportable
      key_size   = var.settings.certificate_policy.key_size
      key_type   = try(var.settings.certificate_policy.key_type, "RSA")
      reuse_key  = var.settings.certificate_policy.reuse_key
    }
    lifetime_action {
      action {
        action_type = var.settings.certificate_policy.renewal_action
      }
      trigger {
        days_before_expiry  = try(var.settings.certificate_policy.days_before_expiry, null)
        lifetime_percentage = try(var.settings.certificate_policy.lifetime_percentage, null)
      }
    }
    secret_properties {
      content_type = var.settings.certificate_policy.content_type
    }

    dynamic x509_certificate_properties {
      for_each = try(var.settings.certificate_policy.x509_certificate_properties, null) == null ? [] : [1]

      content {
        extended_key_usage = try(var.settings.certificate_policy.x509_certificate_properties.extended_key_usage, null)
        key_usage          = var.settings.certificate_policy.x509_certificate_properties.key_usage
        subject            = var.settings.certificate_policy.x509_certificate_properties.subject
        validity_in_months = var.settings.certificate_policy.x509_certificate_properties.validity_in_months

        dynamic subject_alternative_names {
          for_each = try(var.settings.certificate_policy.x509_certificate_properties.subject_alternative_names, null) == null ? [] : [1]

          content {
            dns_names = try(var.settings.certificate_policy.x509_certificate_properties.subject_alternative_names.dns_names)
            emails    = try(var.settings.certificate_policy.x509_certificate_properties.subject_alternative_names.emails)
            upns      = try(var.settings.certificate_policy.x509_certificate_properties.subject_alternative_names.upns)
          }
        }
      }
    }
  }
}