
resource "azurerm_key_vault_certificate" "self_signed_winrm" {
  for_each = {
    for key, value in var.settings.vmss_settings : key => value
    if try(value.winrm.enable_self_signed, false) == true
  }

  name         = format("%s-winrm-cert", azurecaf_name.windows[each.key].result)
  key_vault_id = local.keyvault.id
  tags         = try(merge(var.base_tags, try(each.value.tags, null)), null)

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 4096
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = 30
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

      subject            = format("CN=%s", azurecaf_name.windows[each.key].result)
      validity_in_months = 12

      # TODO: vmss module does not create nic resources, source the dns names to be determined.
      # subject_alternative_names {
      #   dns_names = flatten([
      #     for nic_key in var.settings.vmss_settings[local.os_type].network_interface_keys : format("%s.%s", try(azurerm_network_interface.nic[nic_key].internal_dns_name_label, azurecaf_name.windows[each.key].result), azurerm_network_interface.nic[nic_key].internal_domain_name_suffix)
      #   ])
      # }
    }
  }

  timeouts {
    create = "30m"
    delete = "30m"
    read   = "5m"
  }

}