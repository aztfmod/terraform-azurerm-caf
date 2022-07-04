# Name of the VM in the Azure Control Plane
resource "azurecaf_name" "windows" {
  for_each = local.os_type == "windows" ? var.settings.virtual_machine_settings : {}

  name          = each.value.name
  resource_type = "azurerm_windows_virtual_machine"
  prefixes      = var.global_settings.prefixes
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
  prefixes      = var.global_settings.prefixes
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

resource "azurerm_windows_virtual_machine" "vm" {
  depends_on = [azurerm_network_interface.nic, azurerm_network_interface_security_group_association.nic_nsg]
  for_each   = local.os_type == "windows" ? var.settings.virtual_machine_settings : {}

  admin_password               = try(each.value.admin_password_key, null) == null ? random_password.admin[local.os_type].result : local.admin_password
  admin_username               = try(each.value.admin_username_key, null) == null ? each.value.admin_username : local.admin_username
  allow_extension_operations   = try(each.value.allow_extension_operations, null)
  availability_set_id          = can(each.value.availability_set_key) || can(each.value.availability_set.key) ? var.availability_sets[try(var.client_config.landingzone_key, each.value.availability_set.lz_key)][try(each.value.availability_set_key, each.value.availability_set.key)].id : try(each.value.availability_set.id, each.value.availability_set_id, null)
  computer_name                = azurecaf_name.windows_computer_name[each.key].result
  enable_automatic_updates     = try(each.value.enable_automatic_updates, null)
  encryption_at_host_enabled   = try(each.value.encryption_at_host_enabled, null)
  eviction_policy              = try(each.value.eviction_policy, null)
  license_type                 = try(each.value.license_type, null)
  location                     = var.location
  max_bid_price                = try(each.value.max_bid_price, null)
  name                         = azurecaf_name.windows[each.key].result
  network_interface_ids        = local.nic_ids
  priority                     = try(each.value.priority, null)
  provision_vm_agent           = try(each.value.provision_vm_agent, true)
  proximity_placement_group_id = can(each.value.proximity_placement_group_key) || can(each.value.proximity_placement_group.key) ? var.proximity_placement_groups[try(var.client_config.landingzone_key, var.client_config.landingzone_key)][try(each.value.proximity_placement_group_key, each.value.proximity_placement_group.key)].id : try(each.value.proximity_placement_group_id, each.value.proximity_placement_group.id, null)
  resource_group_name          = var.resource_group_name
  size                         = each.value.size
  tags                         = merge(local.tags, try(each.value.tags, null))
  timezone                     = try(each.value.timezone, null)
  zone                         = try(each.value.zone, null)

  custom_data = try(
    try(filebase64(format("%s/%s", path.cwd, each.value.custom_data)), base64encode(each.value.custom_data)),
    local.dynamic_custom_data[each.value.custom_data][each.value.name],
    null
  )

  dedicated_host_id = can(each.value.dedicated_host.key) ? var.dedicated_hosts[try(each.value.dedicated_host.lz_key, var.client_config.landingzone_key)][each.value.dedicated_host.key].id : try(each.value.dedicated_host.id, null)

  os_disk {
    caching                   = each.value.os_disk.caching
    disk_size_gb              = try(each.value.os_disk.disk_size_gb, null)
    name                      = azurecaf_name.os_disk_windows[each.key].result
    storage_account_type      = each.value.os_disk.storage_account_type
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
    for_each = try(var.boot_diagnostics_storage_account != null ? [1] : var.global_settings.resource_defaults.virtual_machines.use_azmanaged_storage_for_boot_diagnostics == true ? [1] : [], [])

    content {
      storage_account_uri = var.boot_diagnostics_storage_account == "" ? null : var.boot_diagnostics_storage_account
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

  lifecycle {
    ignore_changes = [
      os_disk[0].name, #for ASR disk restores
      admin_username,  # Only used for initial deployment as it can be changed later by GPO
      admin_password   # Only used for initial deployment as it can be changed later by GPO
    ]
  }

}

resource "random_password" "admin" {
  for_each         = (local.os_type == "windows") && (try(var.settings.virtual_machine_settings["windows"].admin_password_key, null) == null) ? var.settings.virtual_machine_settings : {}
  length           = 123
  min_upper        = 2
  min_lower        = 2
  min_special      = 2
  numeric          = true
  special          = true
  override_special = "!@#$%&"
}

resource "azurerm_key_vault_secret" "admin_password" {
  for_each = local.os_type == "windows" && try(var.settings.virtual_machine_settings[local.os_type].admin_password_key, null) == null ? var.settings.virtual_machine_settings : {}

  name         = format("%s-admin-password", azurecaf_name.windows_computer_name[each.key].result)
  value        = random_password.admin[local.os_type].result
  key_vault_id = local.keyvault.id

  lifecycle {
    ignore_changes = [
      value, key_vault_id
    ]
  }
}

#
# Get the admin username and password from keyvault
#

locals {
  admin_username = can(var.settings.virtual_machine_settings["windows"].admin_username_key) ? data.external.windows_admin_username.0.result.value : null
  admin_password = can(var.settings.virtual_machine_settings["windows"].admin_password_key) ? data.external.windows_admin_password.0.result.value : null
}

#
# Use data external to retrieve value from different subscription
#
# With for_each it is not possible to change the provider's subscription at runtime so using the following pattern.
#
data "external" "windows_admin_username" {
  count = try(var.settings.virtual_machine_settings["windows"].admin_username_key, var.settings.virtual_machine_settings["legacy"].admin_password_key, null) == null ? 0 : 1
  program = [
    "bash", "-c",
    format(
      "az keyvault secret show --name '%s' --vault-name '%s' --query '{value: value }' -o json",
      try(var.settings.virtual_machine_settings["windows"].admin_username_key, var.settings.virtual_machine_settings["legacy"].admin_username_key),
      local.keyvault.name
    )
  ]
}

data "external" "windows_admin_password" {
  count = try(var.settings.virtual_machine_settings["windows"].admin_password_key, var.settings.virtual_machine_settings["legacy"].admin_password_key, null) == null ? 0 : 1
  program = [
    "bash", "-c",
    format(
      "az keyvault secret show -n '%s' --vault-name '%s' --query '{value: value }' -o json",
      try(var.settings.virtual_machine_settings["windows"].admin_password_key, var.settings.virtual_machine_settings["legacy"].admin_password_key),
      local.keyvault.name
    )
  ]
}
