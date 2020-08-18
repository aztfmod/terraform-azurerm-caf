

locals {
  os_type = lower(var.settings.os_type)

  managed_identities = flatten([
    for managed_identity_key in lookup(var.settings.virtual_machine_settings[local.os_type], "managed_identity_keys", []) : [
      var.managed_identities[managed_identity_key].id
    ]
  ])
}

resource "tls_private_key" "ssh" {
  for_each = local.os_type == "linux" ? var.settings.virtual_machine_settings : {}

  algorithm = "RSA"
  rsa_bits  = 4096
}

# Name of the VM in the Azure Control Plane
resource "azurecaf_naming_convention" "linux" {
  for_each      = local.os_type == "linux" ? var.settings.virtual_machine_settings : {}
  name          = each.value.name
  prefix        = var.global_settings.prefix
  resource_type = "vml"
  convention    = var.global_settings.convention
}

# Name of the Linux computer name
resource "azurecaf_naming_convention" "linux_computer_name" {
  for_each = local.os_type == "linux" ? var.settings.virtual_machine_settings : {}

  name          = lookup(each.value, "computer_name", each.value.name)
  prefix        = var.global_settings.prefix
  resource_type = "vml"
  convention    = var.global_settings.convention
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each = local.os_type == "linux" ? var.settings.virtual_machine_settings : {}
  # count = lookup(var.virtual_machine_settings, "linux", null) == null ? 0 : 1

  name                  = azurecaf_naming_convention.linux[each.key].result
  location              = var.location
  resource_group_name   = var.resource_group_name
  size                  = each.value.size
  admin_username        = each.value.admin_username
  network_interface_ids = local.nic_ids

  allow_extension_operations      = lookup(each.value, "allow_extension_operations", null)
  computer_name                   = azurecaf_naming_convention.linux_computer_name[each.key].result
  max_bid_price                   = lookup(each.value, "max_bid_price", null)
  priority                        = lookup(each.value, "priority", null)
  provision_vm_agent              = lookup(each.value, "provision_vm_agent", true)
  zone                            = lookup(each.value, "zone", null)
  disable_password_authentication = lookup(each.value, "disable_password_authentication", true)

  dynamic "admin_ssh_key" {
    for_each = lookup(each.value, "disable_password_authentication", true) == true ? [1] : []

    content {
      username   = each.value.admin_username
      public_key = tls_private_key.ssh[each.key].public_key_openssh
    }
  }

  os_disk {
    caching                   = lookup(each.value.os_disk, "caching", null)
    disk_size_gb              = lookup(each.value.os_disk, "disk_size_gb", null)
    name                      = lookup(each.value.os_disk, "name", null)
    storage_account_type      = lookup(each.value.os_disk, "storage_account_type", null)
    write_accelerator_enabled = lookup(each.value.os_disk, "write_accelerator_enabled", false)
  }

  source_image_reference {
    publisher = lookup(each.value.source_image_reference, "publisher", null)
    offer     = lookup(each.value.source_image_reference, "offer", null)
    sku       = lookup(each.value.source_image_reference, "sku", null)
    version   = lookup(each.value.source_image_reference, "version", null)
  }

  dynamic "identity" {
    for_each = lookup(each.value, "managed_identity_keys", false) == false ? [] : [1]

    content {
      type         = "UserAssigned"
      identity_ids = local.managed_identities
    }
  }

  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics_storage_account == {} ? [] : [1]

    content {
      storage_account_uri = data.azurerm_storage_account.diag.0.primary_blob_endpoint
    }
  }

}