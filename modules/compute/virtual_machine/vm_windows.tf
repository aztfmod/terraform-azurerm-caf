# Name of the VM in the Azure Control Plane
resource "azurecaf_name" "windows" {
  for_each = local.os_type == "windows" ? var.settings.virtual_machine_settings : {}

  name          = each.value.name
  resource_type = "azurerm_windows_virtual_machine"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Name of the Windows computer name
resource "azurecaf_name" "windows_computer_name" {
  for_each = local.os_type == "windows" ? var.settings.virtual_machine_settings : {}

  name          = try(each.value.computer_name, each.value.name)
  resource_type = "azurerm_windows_virtual_machine"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Name for the OS disk
resource "azurecaf_name" "os_disk_windows" {
  for_each = local.os_type == "windows" ? var.settings.virtual_machine_settings : {}

  name          = try(each.value.os_disk.name, null)
  resource_type = "azurerm_managed_disk"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_windows_virtual_machine" "vm" {
  for_each = local.os_type == "windows" ? var.settings.virtual_machine_settings : {}

  name                       = azurecaf_name.windows[each.key].result
  location                   = var.location
  resource_group_name        = var.resource_group_name
  size                       = each.value.size
  admin_username             = each.value.admin_username
  admin_password             = random_password.admin[local.os_type].result
  network_interface_ids      = local.nic_ids
  allow_extension_operations = try(each.value.allow_extension_operations, null)
  computer_name              = azurecaf_name.windows_computer_name[each.key].result
  provision_vm_agent         = try(each.value.provision_vm_agent, true)
  zone                       = try(each.value.zone, null)
  custom_data                = try(each.value.custom_data, null) == null ? null : filebase64(format("%s/%s", path.cwd, each.value.custom_data))
  enable_automatic_updates   = try(each.value.enable_automatic_updates, null)
  eviction_policy            = try(each.value.eviction_policy, null)
  max_bid_price              = try(each.value.max_bid_price, null)
  priority                   = try(each.value.priority, null)
  license_type               = try(each.value.license_type, null)
  tags                       = merge(local.tags, try(each.value.tags, null))
  timezone                   = try(each.value.timezone, null)

  os_disk {
    caching                   = each.value.os_disk.caching
    disk_size_gb              = try(each.value.os_disk.disk_size_gb, null)
    name                      = azurecaf_name.os_disk_windows[each.key].result
    storage_account_type      = each.value.os_disk.storage_account_type
    write_accelerator_enabled = try(each.value.os_disk.write_accelerator_enabled, false)

    dynamic "diff_disk_settings" {
      for_each = try(each.value.diff_disk_settings, false) == false ? [] : [1]

      content {
        option = each.value.diff_disk_settings.option
      }
    }
  }

  source_image_reference {
    publisher = try(each.value.source_image_reference.publisher, null)
    offer     = try(each.value.source_image_reference.offer, null)
    sku       = try(each.value.source_image_reference.sku, null)
    version   = try(each.value.source_image_reference.version, null)
  }

  dynamic "additional_capabilities" {
    for_each = try(each.value.additional_capabilities, false) == false ? [] : [1]

    content {
      ultra_ssd_enabled = each.value.additional_capabilities.ultra_ssd_enabled
    }
  }

  dynamic "additional_unattend_content" {
    for_each = try(each.value.additional_unattend_content, false) == false ? [] : [1]

    content {
      content = each.value.additional_unattend_content.content
      setting = each.value.additional_unattend_content.setting
    }
  }

  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics_storage_account == {} ? [] : [1]

    content {
      storage_account_uri = var.boot_diagnostics_storage_account
    }
  }

  dynamic "secret" {
    for_each = try(each.value.winrm.enable_self_signed, false) == false ? [] : [1]

    content {

      key_vault_id = var.keyvault_id

      # WinRM certificate
      dynamic "certificate" {
        for_each = try(each.value.winrm.enable_self_signed, false) == false ? [] : [1]

        content {
          url   = azurerm_key_vault_certificate.self_signed_winrm[each.key].secret_id
          store = "My"
        }
      }
    }
  }

  dynamic "identity" {
    for_each = try(each.value.identity, false) == false ? [] : [1]

    content {
      type         = each.value.identity.type
      identity_ids = local.managed_identities
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

  dynamic "winrm_listener" {
    for_each = try(each.value.winrm, false) == false ? [] : [1]

    content {
      protocol        = try(each.value.winrm.protocol, "Https")
      certificate_url = try(each.value.winrm.enable_self_signed, false) ? azurerm_key_vault_certificate.self_signed_winrm[each.key].secret_id : each.value.winrm.certificate_url
    }
  }

}

resource "random_password" "admin" {
  for_each         = local.os_type == "windows" ? var.settings.virtual_machine_settings : {}
  length           = 123
  min_upper        = 2
  min_lower        = 2
  min_special      = 2
  number           = true
  special          = true
  override_special = "!@#$%&"
}

resource "azurerm_key_vault_secret" "admin_password" {
  for_each = local.os_type == "windows" ? var.settings.virtual_machine_settings : {}

  name         = format("%s-admin-password", azurecaf_name.windows_computer_name[each.key].result)
  value        = random_password.admin[local.os_type].result
  key_vault_id = var.keyvault_id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}