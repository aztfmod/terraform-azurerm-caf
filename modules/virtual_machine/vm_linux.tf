

locals {
  os_type          = lower(keys(var.virtual_machine_settings)[0])
  linux_settings   = lookup(var.virtual_machine_settings, "linux", null)
  windows_settings = lookup(var.virtual_machine_settings, "windows", null)

  managed_identities = flatten([
    for managed_identity_key in lookup(var.virtual_machine_settings[local.os_type], "managed_identity_keys", []) : [
      var.managed_identities[managed_identity_key].id
    ]
  ])
}

resource "tls_private_key" "ssh" {
  count = var.public_key_pem_file == "" ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = 4096
}

locals {
  public_key = tls_private_key.ssh.0.public_key_openssh
}

# Name of the VM in the Azure Control Plane
resource "azurecaf_naming_convention" "vm" {
  name          = local.linux_settings.name
  prefix        = var.global_settings.prefix
  resource_type = "vml"
  convention    = var.global_settings.convention
}

# Name of the Linux computer name
resource "azurecaf_naming_convention" "computer_name" {
  name          = lookup(local.linux_settings, "computer_name", local.linux_settings.name)
  prefix        = var.global_settings.prefix
  resource_type = "vml"
  convention    = var.global_settings.convention
}

resource "azurerm_linux_virtual_machine" "vm" {
  count = lookup(var.virtual_machine_settings, "linux", null) == null ? 0 : 1

  name                  = azurecaf_naming_convention.vm.result
  location              = var.location
  resource_group_name   = var.resource_group_name
  size                  = local.linux_settings.size
  admin_username        = local.linux_settings.admin_username
  network_interface_ids = local.nic_ids

  allow_extension_operations      = lookup(local.linux_settings, "allow_extension_operations", null)
  computer_name                   = azurecaf_naming_convention.computer_name.result
  max_bid_price                   = lookup(local.linux_settings, "max_bid_price", null)
  priority                        = lookup(local.linux_settings, "priority", null)
  provision_vm_agent              = lookup(local.linux_settings, "provision_vm_agent", true)
  zone                            = lookup(local.linux_settings, "zone", null)
  disable_password_authentication = lookup(local.linux_settings, "disable_password_authentication", true)

  dynamic "admin_ssh_key" {
    for_each = lookup(local.linux_settings, "disable_password_authentication", true) == true ? [1] : []

    content {
      username   = local.linux_settings.admin_username
      public_key = local.public_key
    }
  }

  os_disk {
    caching                   = lookup(local.linux_settings.os_disk, "caching", null)
    disk_size_gb              = lookup(local.linux_settings.os_disk, "disk_size_gb", null)
    name                      = lookup(local.linux_settings.os_disk, "name", null)
    storage_account_type      = lookup(local.linux_settings.os_disk, "storage_account_type", null)
    write_accelerator_enabled = lookup(local.linux_settings.os_disk, "write_accelerator_enabled", false)
  }

  source_image_reference {
    publisher = lookup(local.linux_settings.source_image_reference, "publisher", null)
    offer     = lookup(local.linux_settings.source_image_reference, "offer", null)
    sku       = lookup(local.linux_settings.source_image_reference, "sku", null)
    version   = lookup(local.linux_settings.source_image_reference, "version", null)
  }

  dynamic "identity" {
    for_each = lookup(var.virtual_machine_settings[local.os_type], "managed_identity_keys", false) == false ? [] : [1]

    content {
      type         = "UserAssigned"
      identity_ids = local.managed_identities
    }
  }

}