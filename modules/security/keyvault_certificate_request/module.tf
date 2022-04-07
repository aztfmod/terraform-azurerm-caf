resource "azurerm_key_vault_certificate" "csr" {
  name         = var.settings.name
  key_vault_id = var.keyvault_id

  certificate_policy {
    issuer_parameters {
      name = try(var.certificate_issuers[var.settings.certificate_policy.issuer_key_or_name].issuer_name, var.settings.certificate_policy.issuer_key_or_name)
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

    dynamic "x509_certificate_properties" {
      for_each = try(var.settings.certificate_policy.x509_certificate_properties[*], {})

      content {
        extended_key_usage = try(x509_certificate_properties.value.extended_key_usage, null)
        key_usage          = x509_certificate_properties.value.key_usage
        # subject            = x509_certificate_properties.value.subject
        subject            = try(x509_certificate_properties.value.subject, "CN=${try("${x509_certificate_properties.value.domain_name_registration.subdomain}.", "")}${var.domain_name_registrations[try(x509_certificate_properties.value.domain_name_registration.lz_key, var.client_config.landingzone_key)][x509_certificate_properties.value.domain_name_registration.key].dns_domain_registration_name}")
        validity_in_months = x509_certificate_properties.value.validity_in_months

        dynamic "subject_alternative_names" {
          for_each = try(x509_certificate_properties.value.subject_alternative_names, null) == null ? [] : [1]

          content {
            dns_names = try(x509_certificate_properties.value.subject_alternative_names.dns_names)
            emails    = try(x509_certificate_properties.value.subject_alternative_names.emails)
            upns      = try(x509_certificate_properties.value.subject_alternative_names.upns)
          }
        }
      }
    }
  }
}
