output id {
  value = local.os_type == "linux" ? try(azurerm_linux_virtual_machine.vm["linux"].id, null) : try(azurerm_windows_virtual_machine.vm["windows"].id, null)
}

output os_type {
  value = local.os_type
}

output internal_fqdns {
  value = flatten([
    for nic_key in var.settings.virtual_machine_settings[local.os_type].network_interface_keys : format("%s.%s", try(azurerm_network_interface.nic[nic_key].internal_dns_name_label, try(azurerm_linux_virtual_machine.vm["linux"].name, azurerm_windows_virtual_machine.vm["windows"].name)), azurerm_network_interface.nic[nic_key].internal_domain_name_suffix)
  ])
}

output admin_username {
  value       = var.settings.virtual_machine_settings[local.os_type].admin_username
  description = "Local admin username"
}


output winrm {
  value = local.os_type == "windows" ? {
    keyvault_id     = var.keyvault_id
    certificate_url = try(azurerm_key_vault_certificate.self_signed_winrm[local.os_type].secret_id, null)
  } : null
}

output ssh_keys {
  value = local.os_type == "linux" ? {
    keyvault_id              = var.keyvault_id
    ssh_private_key_pem      = azurerm_key_vault_secret.ssh_private_key[local.os_type].name
    ssh_private_key_open_ssh = azurerm_key_vault_secret.ssh_public_key_openssh[local.os_type].name
  } : null
}
