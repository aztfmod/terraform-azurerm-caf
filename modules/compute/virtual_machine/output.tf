output "id" {
  value = local.os_type == "linux" ? try(azurerm_linux_virtual_machine.vm["linux"].id, null) : try(azurerm_windows_virtual_machine.vm["windows"].id, null)
}

output "ip_configuration" {
  value       = azurerm_network_interface.nic
  description = "Adding the network_interface.nic to support remote dns on virtual networks"
}

output "os_type" {
  value = local.os_type
}

output "internal_fqdns" {
  value = try(var.settings.networking_interfaces, null) != null ? flatten([
    for nic_key in try(var.settings.virtual_machine_settings[local.os_type].network_interface_keys, []) : format("%s.%s", try(azurerm_network_interface.nic[nic_key].internal_dns_name_label, try(azurerm_linux_virtual_machine.vm["linux"].name, azurerm_windows_virtual_machine.vm["windows"].name)), azurerm_network_interface.nic[nic_key].internal_domain_name_suffix)
  ]) : null
}

output "admin_username" {
  value       = try(local.admin_username, null) == null ? var.settings.virtual_machine_settings[local.os_type].admin_username : local.admin_username
  description = "Local admin username"
}

output "admin_password_secret_id" {
  value       = try(azurerm_key_vault_secret.admin_password[local.os_type].id, null)
  description = "Local admin password Key Vault secret id"
}

output "winrm" {
  value = local.os_type == "windows" ? {
    keyvault_id     = local.keyvault.id
    certificate_url = try(azurerm_key_vault_certificate.self_signed_winrm[local.os_type].secret_id, null)
  } : null
}

output "ssh_keys" {
  value = local.create_sshkeys ? {
    keyvault_id              = local.keyvault.id
    ssh_private_key_pem      = azurerm_key_vault_secret.ssh_private_key[local.os_type].name
    ssh_public_key_open_ssh  = azurerm_key_vault_secret.ssh_public_key_openssh[local.os_type].name
    ssh_private_key_open_ssh = azurerm_key_vault_secret.ssh_public_key_openssh[local.os_type].name #for backard compat, wrong name, will be removed in future version.
  } : null
}

output "nic_id" {
  value = coalescelist(
    flatten(
      [
        for nic_key in try(var.settings.virtual_machine_settings[local.os_type].network_interface_keys, []) : format("%s.%s", try(azurerm_network_interface.nic[nic_key].id, try(azurerm_linux_virtual_machine.vm["linux"].name, azurerm_windows_virtual_machine.vm["windows"].name)), azurerm_network_interface.nic[nic_key].id)
      ]
    ),
    try(var.settings.networking_interface_ids, [])
  )
}

output "nics" {
  value = {
    for key, value in var.settings.networking_interfaces : key => {
      id   = azurerm_network_interface.nic[key].id
      name = azurerm_network_interface.nic[key].name
    }
  }
}

output "data_disks" {
  value = {
    for key, value in lookup(var.settings, "data_disks", {}) : key => azurerm_managed_disk.disk[key].id
  }
}

# azurerm_linux_virtual_machine and azurerm_windows_virtual_machine do not expose the os_disk id by itself
data "azurerm_managed_disk" "os_disk" {
  name                = local.os_type == "linux" ? try(azurerm_linux_virtual_machine.vm["linux"].os_disk[0].name, null) : try(azurerm_windows_virtual_machine.vm["windows"].os_disk[0].name, null)
  resource_group_name = var.resource_group_name
}

output "os_disk_id" {
  value = data.azurerm_managed_disk.os_disk.id
}