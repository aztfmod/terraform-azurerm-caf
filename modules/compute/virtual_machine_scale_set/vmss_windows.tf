# Name of the VMSS in the Azure Control Plane
resource "azurecaf_name" "windows" {
  for_each = local.os_type == "windows" ? var.settings.vmss_settings : {}

  name          = each.value.name
  resource_type = "azurerm_virtual_machine_scale_set"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}


# Name of the windows computer name
resource "azurecaf_name" "windows_computer_name_prefix" {
  for_each = local.os_type == "windows" ? var.settings.vmss_settings : {}

  name          = try(each.value.computer_name, each.value.name)
  resource_type = "azurerm_virtual_machine_scale_set"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Name for the OS disk
resource "azurecaf_name" "os_disk_windows" {
  for_each = local.os_type == "windows" ? var.settings.vmss_settings : {}

  name          = try(each.value.os_disk.name, null)
  resource_type = "azurerm_managed_disk"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_windows_virtual_machine_scale_set" "vmss" {
  for_each = local.os_type == "windows" ? var.settings.vmss_settings : {}

  name                = azurecaf_name.windows[each.key].result
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = each.value.sku
  instances           = each.value.instances
  admin_username      = try(each.value.admin_username_key, null) == null ? each.value.admin_username : local.admin_username
  admin_password      = try(each.value.admin_password_key, null) == null ? random_password.admin[local.os_type].result : local.admin_password
  tags                = merge(local.tags, try(each.value.tags, null))

  #TODO: Standardize the prefix length?
  computer_name_prefix            = substr(azurecaf_name.windows_computer_name_prefix[each.key].result,0,6)
  eviction_policy                 = try(each.value.eviction_policy, null)
  max_bid_price                   = try(each.value.max_bid_price, null)
  priority                        = try(each.value.priority, null)
  provision_vm_agent              = try(each.value.provision_vm_agent, true)
  zones                           = try(each.value.zones, null)
  custom_data                     = try(each.value.custom_data, null) == null ? null : filebase64(format("%s/%s", path.cwd, each.value.custom_data))
  proximity_placement_group_id    = try(var.proximity_placement_groups[var.client_config.landingzone_key][each.value.proximity_placement_group_key].id, var.proximity_placement_groups[each.value.proximity_placement_groups].id, null)

  dynamic "network_interface" {
    for_each = each.value.networking_interfaces

    content {
      name    = "${azurecaf_name.windows_computer_name_prefix[each.key].result}-nic-${network_interface.value.name}"
      primary = try(network_interface.value.primary, false)

      ip_configuration {
        name      = "${azurecaf_name.windows_computer_name_prefix[each.key].result}-nic-${network_interface.value.name}-ipconfig"
        primary   = try(network_interface.value.primary, false)
        subnet_id = try(var.vnets[var.client_config.landingzone_key][network_interface.value.vnet_key].subnets[network_interface.value.subnet_key].id, var.vnets[network_interface.value.lz_key][network_interface.value.vnet_key].subnets[network_interface.value.subnet_key].id)
      }
    }
  }

  os_disk {
    caching                   = try(each.value.os_disk.caching, null)
    disk_size_gb              = try(each.value.os_disk.disk_size_gb, null)
    storage_account_type      = try(each.value.os_disk.storage_account_type, null)
    write_accelerator_enabled = try(each.value.os_disk.write_accelerator_enabled, false)
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

  source_image_id = try(each.value.custom_image_id, var.custom_image_ids[each.value.lz_key][each.value.custom_image_key].id, null)

  dynamic "identity" {
    for_each = try(each.value.identity, false) == false ? [] : [1]

    content {
      type         = each.value.identity.type
      identity_ids = local.managed_identities
    }
  }

  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics_storage_account == {} ? [] : [1]

    content {
      storage_account_uri = var.boot_diagnostics_storage_account
    }
  }

  dynamic "extension" {
    for_each = try(each.value.extensions, {})

    content {
      name                       = try(extension.value.name, null)
      publisher                  = try(extension.value.publisher, null)
      type                       = try(extension.value.type, null)
      type_handler_version       = try(extension.value.type_handler_version, null)
      auto_upgrade_minor_version = try(extension.value.auto_upgrade_minor_version, null)
      force_update_tag           = try(extension.value.force_update_tag, null)
      protected_settings         = try(extension.value.protected_settings, null)
      provision_after_extensions = try(extension.value.provision_after_extensions, null)
      settings                   = try(extension.value.settings, null)
    }
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

  dynamic "secret" {
    for_each = try(each.value.winrm.enable_self_signed, false) == false ? [] : [1]

    content {

      key_vault_id = local.keyvault.id

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
  for_each         = (local.os_type == "windows") && (try(var.settings.vmss_settings["windows"].admin_password_key, null) == null) ? var.settings.vmss_settings : {}
  length           = 123
  min_upper        = 2
  min_lower        = 2
  min_special      = 2
  number           = true
  special          = true
  override_special = "!@#$%&"
}

resource "azurerm_key_vault_secret" "admin_password" {
  for_each = local.os_type == "windows" && try(var.settings.vmss_settings[local.os_type].admin_password_key, null) == null ? var.settings.vmss_settings : {}

  name         = format("%s-admin-password", azurecaf_name.windows_computer_name_prefix[each.key].result)
  value        = random_password.admin[local.os_type].result
  key_vault_id = local.keyvault.id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}


#
# Get the admin username and password from keyvault
#

locals {
  admin_username = try(data.external.windows_admin_username.0.result.value, null)
  admin_password = try(data.external.windows_admin_password.0.result.value, null)
}

#
# Use data external to retrieve value from different subscription
#
# With for_each it is not possible to change the provider's subscription at runtime so using the following pattern.
#
data external windows_admin_username {
  count = try(var.settings.vmss_settings["windows"].admin_username_key, null) == null ? 0 : 1
  program = [
    "bash", "-c",
    format(
      "az keyvault secret show --name '%s' --vault-name '%s' --query '{value: value }' -o json",
      var.settings.vmss_settings["windows"].admin_username_key,
      local.keyvault.name
    )
  ]
}

data external windows_admin_password {
  count = try(var.settings.vmss_settings["windows"].admin_password_key, null) == null ? 0 : 1
  program = [
    "bash", "-c",
    format(
      "az keyvault secret show -n '%s' --vault-name '%s' --query '{value: value }' -o json",
      var.settings.vmss_settings["windows"].admin_password_key,
      local.keyvault.name
    )
  ]
}
