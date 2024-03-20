resource "azurerm_site_recovery_replicated_vm" "replication" {
  count = try(var.settings.replication, null) == null ? 0 : 1

  name                = "${var.virtual_machine_name}-repl"
  resource_group_name = coalesce(
    try(var.settings.replication.recovery_vault_rg, null),
    try(split("/", var.settings.replication.recovery_vault_id)[4], null),
    try(var.recovery_vaults[var.client_config.landingzone_key][var.settings.replication.vault_key].resource_group_name, null),
    try(var.recovery_vaults[var.settings.replication.lz_key][var.settings.replication.vault_key].resource_group_name, null)
  )

  recovery_vault_name = coalesce(
    try(var.settings.replication.recovery_vault_name, null),
    try(split("/", var.settings.replication.recovery_vault_id)[8], null),
    try(var.recovery_vaults[var.client_config.landingzone_key][var.settings.replication.vault_key].name, null),
    try(var.recovery_vaults[var.settings.replication.lz_key][var.settings.replication.vault_key].name, null)
  )
  recovery_replication_policy_id = coalesce(
    try(var.settings.replication.replication_policy_id, null),
    try(var.recovery_vaults[var.client_config.landingzone_key][var.settings.replication.vault_key].replication_policies[var.settings.replication.policy_key].id, null),
    try(var.recovery_vaults[var.settings.replication.lz_key][var.settings.replication.vault_key].replication_policies[var.settings.replication.policy_key].id, null)
  )

  source_recovery_fabric_name = coalesce(
    try(var.settings.replication.source.recovery_fabric_name, null),
    try(var.recovery_vaults[var.client_config.landingzone_key][var.settings.replication.vault_key].recovery_fabrics[var.settings.replication.source.recovery_fabric_key].name, null),
    try(var.recovery_vaults[var.settings.replication.lz_key][var.settings.replication.vault_key].recovery_fabrics[var.settings.replication.source.recovery_fabric_key].name, null)
  )
  source_vm_id = var.virtual_machine_id
  source_recovery_protection_container_name = coalesce(
    try(var.settings.replication.source.protection_container_name, null),
    try(var.recovery_vaults[var.client_config.landingzone_key][var.settings.replication.vault_key].protection_containers[var.settings.replication.source.protection_container_key].name, null),
    try(var.recovery_vaults[var.settings.replication.lz_key][var.settings.replication.vault_key].protection_containers[var.settings.replication.source.protection_container_key].name, null)
  )

  target_resource_group_id = coalesce(
    try(var.resource_groups[var.client_config.landingzone_key][var.settings.replication.target.resource_group_key].id, null),
    try(var.recovery_vaults[var.settings.replication.target.resource_group.lz_key][var.settings.replication.resource_group.key].id, null)
  )
  target_recovery_fabric_id = coalesce(
    try(var.settings.replication.target.recovery_fabric_id, null),
    try(var.recovery_vaults[var.client_config.landingzone_key][var.settings.replication.vault_key].recovery_fabrics[var.settings.replication.target.recovery_fabric_key].id, null),
    try(var.recovery_vaults[var.settings.replication.lz_key][var.settings.replication.vault_key].recovery_fabrics[var.settings.replication.target.recovery_fabric_key].id, null)
  )
  target_recovery_protection_container_id = coalesce(
    try(var.settings.replication.source.protection_container_id, null),
    try(var.recovery_vaults[var.client_config.landingzone_key][var.settings.replication.vault_key].protection_containers[var.settings.replication.target.protection_container_key].id, null),
    try(var.recovery_vaults[var.settings.replication.lz_key][var.settings.replication.vault_key].protection_containers[var.settings.replication.target.protection_container_key].id, null)
  )
  target_zone = try(var.settings.replication.target.zone, "")
  target_network_id = coalesce(
    try(var.settings.replication.target.network.vnet_id, null),
    try(var.vnets[try(var.settings.replication.target.network.lz_key, var.client_config.landingzone_key)][var.settings.replication.target.network.vnet_key].id, null)
  )

  test_network_id = coalesce(
    try(var.settings.replication.target.test_network.vnet_id, null),
    try(var.vnets[try(var.settings.replication.target.test_network.lz_key, var.client_config.landingzone_key)][var.settings.replication.target.test_network.vnet_key].id, null)
  )

  managed_disk {
      disk_id = var.virtual_machine_os_disk.id
      staging_storage_account_id = coalesce(
        try(var.storage_accounts[var.client_config.landingzone_key][var.settings.replication.staging_storage_account_key].id, null),
        try(var.storage_accounts[var.settings.replication.staging_storage_account.lz_key][var.settings.replication.staging_storage_account.key].id, null)
      )
      target_resource_group_id      = coalesce(
        try(var.resource_groups[var.client_config.landingzone_key][var.settings.replication.target.resource_group_key].id, null),
        try(var.recovery_vaults[var.settings.replication.target.resource_group.lz_key][var.settings.replication.resource_group.key].id, null)
      )
      target_disk_type              = var.virtual_machine_os_disk.storage_account_type
      target_replica_disk_type      = var.virtual_machine_os_disk.storage_account_type
      target_disk_encryption_set_id = try(var.virtual_machine_os_disk.disk_encryption_set_id, null)
  }

  dynamic "managed_disk" {
    for_each = lookup(var.settings, "data_disks", {})
    content {
      disk_id                    = var.virtual_machine_data_disks[managed_disk.key]
      staging_storage_account_id = coalesce(
        try(var.storage_accounts[var.client_config.landingzone_key][var.settings.replication.staging_storage_account_key].id, null),
        try(var.storage_accounts[var.settings.replication.staging_storage_account.lz_key][var.settings.replication.staging_storage_account.key].id, null)
      )
      target_resource_group_id      = coalesce(
        try(var.resource_groups[var.client_config.landingzone_key][var.settings.replication.target.resource_group_key].id, null),
        try(var.recovery_vaults[var.settings.replication.target.resource_group.lz_key][var.settings.replication.resource_group.key].id, null)
      )
      target_disk_type              = managed_disk.value.storage_account_type
      target_replica_disk_type      = managed_disk.value.storage_account_type
      target_disk_encryption_set_id = try(managed_disk.value.disk_encryption_set_key, null) == null ? null : var.disk_encryption_sets[try(managed_disk.value.lz_key, var.client_config.landingzone_key)][managed_disk.value.disk_encryption_set_key].id
    }
  }

  dynamic "network_interface" {
    for_each = var.virtual_machine_nics
    content {
      source_network_interface_id = network_interface.value.id
      target_subnet_name          = can(var.settings.replication.target.network.subnet_name) ? var.settings.replication.target.network.subnet_name : var.vnets[try(var.settings.replication.target.network.lz_key, var.client_config.landingzone_key)][var.settings.replication.target.network.vnet_key].subnets[var.settings.replication.target.network.subnet_key].name
      failover_test_subnet_name   = can(var.settings.replication.target.test_network.subnet_name) ? var.settings.replication.target.test_network.subnet_name : var.vnets[try(var.settings.replication.target.test_network.lz_key, var.client_config.landingzone_key)][var.settings.replication.target.test_network.vnet_key].subnets[var.settings.replication.target.test_network.subnet_key].name
    }
  }

  timeouts {
    create = "6h"
  }
}