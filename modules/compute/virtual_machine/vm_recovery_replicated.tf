resource "azurerm_site_recovery_replicated_vm" "vm-replication" {
  name                                      = var.settings.recovery_replication.name
  resource_group_name                       = var.resource_group_name
  recovery_vault_name                       = coalesce(
    try(var.settings.recovery_replication.recovery_vault_name, null),
    try(var.recovery_vaults[var.client_config.landingzone_key][var.settings.recovery_replication.recovery_vault_key].name, null),
    try(var.recovery_vaults[var.settings.recovery_replication.recovery_vault.lz_key][var.settings.recovery_replication.recovery_vault.vault_key].name, null)
  )
  source_recovery_fabric_name               = coalesce(
    try(var.settings.recovery_replication.source_recovery_fabric_name, null),
    try(var.recovery_vaults[var.client_config.landingzone_key][var.settings.recovery_replication.recovery_vault_key].recovery_fabrics[var.settings.recovery_replication.source_recovery_fabric_key].name, null),
    try(var.recovery_vaults[var.settings.recovery_replication.recovery_vault.lz_key][var.settings.recovery_replication.recovery_vault.vault_key].recovery_fabrics[var.settings.recovery_replication.source_recovery_fabric_key].name, null)
  )
  source_vm_id                              = local.os_type == "linux" ? azurerm_linux_virtual_machine.vm["linux"].id : azurerm_windows_virtual_machine.vm["windows"].id
  recovery_replication_policy_id            = coalesce(
    try(var.settings.recovery_replication.replication_policy_id, null),
    try(var.recovery_vaults[var.client_config.landingzone_key][var.settings.recovery_replication.recovery_vault_key].replication_policies[var.settings.recovery_replication.replication_policy_key].id, null),
    try(var.recovery_vaults[var.settings.recovery_replication.recovery_vault.lz_key][var.settings.recovery_replication.recovery_vault.vault_key].replication_policies[var.settings.recovery_replication.replication_policy_key].id, null)
  )
  source_recovery_protection_container_name = coalesce(
    try(var.settings.recovery_replication.source_protection_container_name, null),
    try(var.recovery_vaults[var.client_config.landingzone_key][var.settings.recovery_replication.recovery_vault_key].protection_containers[var.settings.recovery_replication.source_protection_container_key].name, null),
    try(var.recovery_vaults[var.settings.recovery_replication.recovery_vault.lz_key][var.settings.recovery_replication.recovery_vault.vault_key].protection_containers[var.settings.recovery_replication.source_protection_container_key].name, null)
  )

  target_resource_group_id                = coalesce(
    try(var.resource_groups[var.settings.recovery_replication.target_resource_group.lz_key][var.settings.recovery_replication.target_resource_group.key].id, null),
    try(var.resource_groups[var.client_config.landingzone_key][var.settings.recovery_replication.target_resource_group_key].id, null)
  )
  target_recovery_fabric_id               = coalesce(
    try(var.settings.recovery_replication.target_recovery_fabric_id, null),
    try(var.recovery_vaults[var.client_config.landingzone_key][var.settings.recovery_replication.recovery_vault_key].recovery_fabrics[var.settings.recovery_replication.target_recovery_fabric_key].id, null),
    try(var.recovery_vaults[var.settings.recovery_replication.recovery_vault.lz_key][var.settings.recovery_replication.recovery_vault.vault_key].recovery_fabrics[var.settings.recovery_replication.target_recovery_fabric_key].id, null)
  )
  target_recovery_protection_container_id = coalesce(
    try(var.settings.recovery_replication.target_protection_container_id, null),
    try(var.recovery_vaults[var.client_config.landingzone_key][var.settings.recovery_replication.recovery_vault_key].protection_containers[var.settings.recovery_replication.target_protection_container_key].id, null),
    try(var.recovery_vaults[var.settings.recovery_replication.recovery_vault.lz_key][var.settings.recovery_replication.recovery_vault.vault_key].protection_containers[var.settings.recovery_replication.target_protection_container_key].id, null)
  )

  managed_disk {
    disk_id                    = data.azurerm_managed_disk.existing.id
    staging_storage_account_id = var.storage_accounts[try(var.settings.recovery_replication.managed_os_disk.storage_account.lz_key, var.client_config.landingzone_key)][var.settings.recovery_replication.managed_os_disk.storage_account.key].id
    target_resource_group_id   = coalesce(
    try(var.resource_groups[var.settings.recovery_replication.target_resource_group.lz_key][var.settings.recovery_replication.target_resource_group.key].id, null),
    try(var.resource_groups[var.client_config.landingzone_key][var.settings.recovery_replication.target_resource_group_key].id, null)
  )
    target_disk_type           = var.settings.recovery_replication.managed_os_disk.target_disk_type
    target_replica_disk_type   = var.settings.recovery_replication.managed_os_disk.target_disk_type
  }


  dynamic "managed_disk" {
    for_each = try(var.settings.recovery_replication.managed_disks,{})

    content {
    disk_id                    = azurerm_managed_disk.disk[managed_disk.value.disk_key].id
    staging_storage_account_id = var.storage_accounts[try(managed_disk.value.storage_account.lz_key, var.client_config.landingzone_key)][managed_disk.value.storage_account.key].id
    target_resource_group_id   = coalesce(
    try(var.resource_groups[managed_disk.value.target_resource_group.lz_key][managed_disk.value.target_resource_group.key].id, null),
    try(var.resource_groups[var.client_config.landingzone_key][managed_disk.value.target_resource_group.key].id, null)
  )
    target_disk_type           = managed_disk.value.target_disk_type
    target_replica_disk_type   = managed_disk.value.target_replica_disk_type
  }
  }

  dynamic "network_interface" {
    for_each = try(var.settings.recovery_replication.network_interfaces, {})

    content {
    source_network_interface_id   = azurerm_network_interface.nic[var.settings.recovery_replication.network_interfaces[network_interface.key].source_interface_key].id
    target_subnet_name            = coalesce(
    try(network_interface.value.target_subnet_name, null),
    try(var.vnets[network_interface.value.target_subnet.lz_key][network_interface.value.target_subnet.vnet_key].subnets[network_interface.value.target_subnet.subnet_key].name, null),
    try(var.vnets[var.client_config.landingzone_key][network_interface.value.target_subnet.vnet_key].subnets[network_interface.value.target_subnet.subnet_key].name, null)
  )
    target_static_ip = try(network_interface.value.target_static_ip, null)
    recovery_public_ip_address_id = coalesce(
    try(var.settings.recovery_replication.network_interfaces[network_interface.key].recovery_public_ip_address_id, null),
    try(var.public_ip_addresses[network_interface.value.recovery_public_ip_address.lz_key][network_interface.value.recovery_public_ip_address.key].id, null),
    try(var.public_ip_addresses[var.client_config.landingzone_key][network_interface.value.recovery_public_ip_address.key].id, null)
  )
    }
  }

  # depends_on = [
  #   azurerm_site_recovery_protection_container_mapping.container-mapping,
  #   azurerm_site_recovery_network_mapping.network-mapping,
  # ]
}