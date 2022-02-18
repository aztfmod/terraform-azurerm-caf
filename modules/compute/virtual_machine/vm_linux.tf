resource "tls_private_key" "ssh" {
  for_each = local.create_sshkeys ? var.settings.virtual_machine_settings : {}

  algorithm = "RSA"
  rsa_bits  = 4096
}

# Name of the VM in the Azure Control Plane
resource "azurecaf_name" "linux" {
  for_each = local.os_type == "linux" ? var.settings.virtual_machine_settings : {}

  name          = each.value.name
  resource_type = "azurerm_linux_virtual_machine"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}


# Name of the Linux computer name
resource "azurecaf_name" "linux_computer_name" {
  depends_on = [azurerm_network_interface.nic, azurerm_network_interface_security_group_association.nic_nsg]
  for_each   = local.os_type == "linux" ? var.settings.virtual_machine_settings : {}

  name          = try(each.value.computer_name, each.value.name)
  resource_type = "azurerm_linux_virtual_machine"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Name for the OS disk
resource "azurecaf_name" "os_disk_linux" {
  for_each = local.os_type == "linux" ? var.settings.virtual_machine_settings : {}

  name          = try(each.value.os_disk.name, null)
  resource_type = "azurerm_managed_disk"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug

  lifecycle {
    ignore_changes = [
      name
    ]
  }

}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each = local.os_type == "linux" ? var.settings.virtual_machine_settings : {}

  admin_password                  = each.value.disable_password_authentication == false ? each.value.admin_password : null
  admin_username                  = each.value.admin_username
  allow_extension_operations      = try(each.value.allow_extension_operations, null)
  availability_set_id             = try(var.availability_sets[var.client_config.landingzone_key][each.value.availability_set_key].id, var.availability_sets[each.value.availability_sets].id, null)
  computer_name                   = azurecaf_name.linux_computer_name[each.key].result
  disable_password_authentication = try(each.value.disable_password_authentication, true)
  eviction_policy                 = try(each.value.eviction_policy, null)
  license_type                    = try(each.value.license_type, null)
  location                        = var.location
  max_bid_price                   = try(each.value.max_bid_price, null)
  name                            = azurecaf_name.linux[each.key].result
  network_interface_ids           = local.nic_ids
  priority                        = try(each.value.priority, null)
  provision_vm_agent              = try(each.value.provision_vm_agent, true)
  proximity_placement_group_id    = try(var.proximity_placement_groups[var.client_config.landingzone_key][each.value.proximity_placement_group_key].id, var.proximity_placement_groups[each.value.proximity_placement_groups].id, null)
  resource_group_name             = var.resource_group_name
  size                            = each.value.size
  tags                            = merge(local.tags, try(each.value.tags, null))
  zone                            = try(each.value.zone, null)

  custom_data = try(
    local.dynamic_custom_data[each.value.custom_data][each.value.name],
    try(filebase64(format("%s/%s", path.cwd, each.value.custom_data)), base64encode(each.value.custom_data)),
    null
  )

  dedicated_host_id = try(coalesce(
    try(each.value.dedicated_host.id, null),
    var.dedicated_hosts[try(each.value.dedicated_host.lz_key, var.client_config.landingzone_key)][each.value.dedicated_host.key].id,
    ),
    null
  )

  dynamic "admin_ssh_key" {
    for_each = lookup(each.value, "disable_password_authentication", true) == true ? [1] : []

    content {
      username   = each.value.admin_username
      public_key = local.create_sshkeys ? tls_private_key.ssh[each.key].public_key_openssh : file(var.settings.public_key_pem_file)
    }
  }

  os_disk {
    caching                   = try(each.value.os_disk.caching, null)
    disk_size_gb              = try(each.value.os_disk.disk_size_gb, null)
    name                      = try(azurecaf_name.os_disk_linux[each.key].result, null)
    storage_account_type      = try(each.value.os_disk.storage_account_type, null)
    write_accelerator_enabled = try(each.value.os_disk.write_accelerator_enabled, false)
    disk_encryption_set_id    = try(each.value.os_disk.disk_encryption_set_key, null) == null ? null : try(var.disk_encryption_sets[var.client_config.landingzone_key][each.value.os_disk.disk_encryption_set_key].id, var.disk_encryption_sets[each.value.os_disk.lz_key][each.value.os_disk.disk_encryption_set_key].id, null)
  }

  dynamic "source_image_reference" {
    for_each = try(each.value.source_image_reference, null) != null ? [1] : []

    content {
      publisher = try(each.value.source_image_reference.publisher, null)
      offer     = try(each.value.source_image_reference.offer, null)
      sku       = try(each.value.source_image_reference.sku, null)
      version   = try(each.value.source_image_reference.version, null)
    }
  }

  source_image_id = try(each.value.source_image_reference, null) == null ? format("%s%s",
    try(each.value.custom_image_id, var.image_definitions[var.client_config.landingzone_key][each.value.custom_image_key].id,
    var.image_definitions[each.value.custom_image_lz_key][each.value.custom_image_key].id),
  try("/versions/${each.value.custom_image_version}", "")) : null

  dynamic "identity" {
    for_each = try(each.value.identity, false) == false ? [] : [1]

    content {
      type         = each.value.identity.type
      identity_ids = local.managed_identities
    }
  }

  dynamic "boot_diagnostics" {
    for_each = try(var.boot_diagnostics_storage_account != null ? [1] : var.global_settings.resource_defaults.virtual_machines.use_azmanaged_storage_for_boot_diagnostics == true ? [1] : [], [])

    content {
      storage_account_uri = var.boot_diagnostics_storage_account == "" ? null : var.boot_diagnostics_storage_account
    }
  }

  dynamic "plan" {
    for_each = try(each.value.plan, false) == false ? [] : [1]

    content {
      name      = each.value.plan.name
      product   = each.value.plan.product
      publisher = each.value.plan.publisher
    }
  }

  lifecycle {
    ignore_changes = [
      resource_group_name, location, os_disk[0].name, availability_set_id
    ]
  }

}

#
# SSH keys to be stored in KV only if public_key_pem_file is not set
#

resource "azurerm_key_vault_secret" "ssh_private_key" {
  for_each = local.create_sshkeys ? var.settings.virtual_machine_settings : {}

  name         = try(format("%s-ssh-private-key", azurecaf_name.linux_computer_name[each.key].result), format("%s-ssh-private-key", azurecaf_name.legacy_computer_name[each.key].result))
  value        = tls_private_key.ssh[each.key].private_key_pem
  key_vault_id = local.keyvault.id

  lifecycle {
    ignore_changes = [
      value, key_vault_id
    ]
  }
}


resource "azurerm_key_vault_secret" "ssh_public_key_openssh" {
  for_each = local.create_sshkeys ? var.settings.virtual_machine_settings : {}

  name         = try(format("%s-ssh-public-key-openssh", azurecaf_name.linux_computer_name[each.key].result), format("%s-ssh-public-key-openssh", azurecaf_name.legacy_computer_name[each.key].result))
  value        = tls_private_key.ssh[each.key].public_key_openssh
  key_vault_id = local.keyvault.id

  lifecycle {
    ignore_changes = [
      value, key_vault_id
    ]
  }
}

