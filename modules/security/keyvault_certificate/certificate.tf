
resource "azurerm_key_vault_certificate" "cert" {

  name         = var.settings.name
  key_vault_id = var.keyvault.id
  tags         = merge(var.settings.tags, var.keyvault.base_tags)

  certificate_policy {
    issuer_parameters {
      name = var.settings.issuer_parameters
    }

    key_properties {
      exportable = var.settings.exportable
      key_size   = var.settings.key_size
      key_type   = var.settings.key_type
      reuse_key  = var.settings.reuse_key
    }

    lifetime_action {
      action {
        action_type = var.settings.action_type
      }

      trigger {
        days_before_expiry  = try(var.settings.lifetime_percentage, null) == null ? var.settings.days_before_expiry : null
        lifetime_percentage = try(var.settings.days_before_expiry, null) == null ? var.settings.lifetime_percentage : null
      }
    }

    secret_properties {
      content_type = var.settings.content_type
    }

    x509_certificate_properties {
      key_usage = var.settings.key_usage

      subject            = var.settings.subject
      validity_in_months = var.settings.validity_in_months

      subject_alternative_names {
        dns_names = try(var.settings.subject_alternative_names.dns_names, null)
        emails    = try(var.settings.subject_alternative_names.emails, null)
        upns      = try(var.settings.subject_alternative_names.upns, null)
      }
    }
  }
}