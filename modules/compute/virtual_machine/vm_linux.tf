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
      name #for ASR disk restores
    ]
  }

}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each = local.os_type == "linux" ? var.settings.virtual_machine_settings : {}

  admin_password                  = each.value.disable_password_authentication == false ? each.value.admin_password : null
  admin_username                  = each.value.admin_username
  allow_extension_operations      = try(each.value.allow_extension_operations, null)
  availability_set_id             = can(each.value.availability_set_key) || can(each.value.availability_set.key) ? var.availability_sets[try(var.client_config.landingzone_key, each.value.availability_set.lz_key)][try(each.value.availability_set_key, each.value.availability_set.key)].id : try(each.value.availability_set.id, each.value.availability_set_id, null)
  computer_name                   = azurecaf_name.linux_computer_name[each.key].result
  disable_password_authentication = try(each.value.disable_password_authentication, true)
  encryption_at_host_enabled      = try(each.value.encryption_at_host_enabled, null)
  eviction_policy                 = try(each.value.eviction_policy, null)
  license_type                    = try(each.value.license_type, null)
  location                        = var.location
  max_bid_price                   = try(each.value.max_bid_price, null)
  name                            = azurecaf_name.linux[each.key].result
  network_interface_ids           = local.nic_ids
  priority                        = try(each.value.priority, null)
  provision_vm_agent              = try(each.value.provision_vm_agent, true)
  proximity_placement_group_id    = can(each.value.proximity_placement_group_key) || can(each.value.proximity_placement_group.key) ? var.proximity_placement_groups[try(var.client_config.landingzone_key, var.client_config.landingzone_key)][try(each.value.proximity_placement_group_key, each.value.proximity_placement_group.key)].id : try(each.value.proximity_placement_group_id, each.value.proximity_placement_group.id, null)
  resource_group_name             = var.resource_group_name
  size                            = each.value.size
  tags                            = merge(local.tags, try(each.value.tags, null))
  zone                            = try(each.value.zone, null)

  custom_data = try(
    local.dynamic_custom_data[each.value.custom_data][each.value.name],
    try(filebase64(format("%s/%s", path.cwd, each.value.custom_data)), base64encode(each.value.custom_data)),
    null
  )

  dedicated_host_id = can(each.value.dedicated_host.key) ? var.dedicated_hosts[try(each.value.dedicated_host.lz_key, var.client_config.landingzone_key)][each.value.dedicated_host.key].id : try(each.value.dedicated_host.id, null)

  # Create local ssh key
  dynamic "admin_ssh_key" {
    for_each = lookup(each.value, "disable_password_authentication", true) == true && local.create_sshkeys ? [1] : []

    content {
      username   = each.value.admin_username
      public_key = local.create_sshkeys ? tls_private_key.ssh[each.key].public_key_openssh : file(var.settings.public_key_pem_file)
    }
  }

  # by ssh_public_key_id
  dynamic "admin_ssh_key" {
    for_each = {
      for key, value in try(each.value.admin_ssh_keys, {}) : key => value if can(value.ssh_public_key_id)
    }

    content {
      # "Destination path for SSH public keys is currently limited to its default value /home/adminuser/.ssh/authorized_keys  due to a known issue in Linux provisioning agent."
      # username   = try(admin_ssh_key.value.username, each.value.admin_username)
      username   = each.value.admin_username
      public_key = replace(data.external.ssh_public_key_id[admin_ssh_key.key].result.public_ssh_key, "\r\n", "")
    }
  }

  # by secret_key_id
  dynamic "admin_ssh_key" {
    for_each = {
      for key, value in try(each.value.admin_ssh_keys, {}) : key => value if can(value.secret_key_id)
    }

    content {
      # "Destination path for SSH public keys is currently limited to its default value /home/adminuser/.ssh/authorized_keys  due to a known issue in Linux provisioning agent."
      # username   = try(admin_ssh_key.value.username, each.value.admin_username)
      username   = each.value.admin_username
      public_key = replace(data.external.secret_key_id[admin_ssh_key.key].result.public_ssh_key, "\r\n", "")
    }
  }

  # by secret_key_id
  dynamic "admin_ssh_key" {
    for_each = {
      for key, value in try(var.settings.virtual_machine_settings[var.settings.os_type].admin_ssh_keys, {}) : key => value if can(value.keyvault_key)
    }

    content {
      # "Destination path for SSH public keys is currently limited to its default value /home/adminuser/.ssh/authorized_keys  due to a known issue in Linux provisioning agent."
      # username   = try(admin_ssh_key.value.username, each.value.admin_username)
      username   = each.value.admin_username
      public_key = replace(data.external.ssh_secret_keyvault[admin_ssh_key.key].result.public_ssh_key, "\r\n", "")
    }
  }

  os_disk {
    caching                   = try(each.value.os_disk.caching, null)
    disk_size_gb              = try(each.value.os_disk.disk_size_gb, null)
    name                      = try(azurecaf_name.os_disk_linux[each.key].result, null)
    storage_account_type      = try(each.value.os_disk.storage_account_type, null)
    write_accelerator_enabled = try(each.value.os_disk.write_accelerator_enabled, false)
    disk_encryption_set_id    = try(each.value.os_disk.disk_encryption_set_key, null) == null ? null : try(var.disk_encryption_sets[var.client_config.landingzone_key][each.value.os_disk.disk_encryption_set_key].id, var.disk_encryption_sets[each.value.os_disk.lz_key][each.value.os_disk.disk_encryption_set_key].id, null)

    dynamic "diff_disk_settings" {
      for_each = try(each.value.diff_disk_settings, false) == false ? [] : [1]

      content {
        option = each.value.diff_disk_settings.option
      }
    }
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
    try(each.value.custom_image_id, var.image_definitions[try(each.value.custom_image_lz_key, var.client_config.landingzone_key)][each.value.custom_image_key].id),
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
      os_disk[0].name, #for ASR disk restores
      admin_ssh_key
    ]
  }

}
