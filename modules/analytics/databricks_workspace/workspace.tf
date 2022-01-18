# Tested with :  AzureRM version 2.74.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_workspace

resource "azurecaf_name" "wp" {
  name          = var.settings.name
  resource_type = "azurerm_databricks_workspace"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_databricks_workspace" "ws" {
  name                        = azurecaf_name.wp.result
  resource_group_name         = var.resource_group.name
  location                    = local.location
  sku                         = try(var.settings.sku, "standard")
  managed_resource_group_name = try(var.settings.managed_resource_group_name, null)
  tags                        = try(local.tags, null)

  #todo:
  #load_balancer_backend_address_pool_id
  #managed_services_cmk_key_vault_key_id

  infrastructure_encryption_enabled     = try(var.settings.infrastructure_encryption_enabled, null)
  public_network_access_enabled         = try(var.settings.public_network_access_enabled, null)
  network_security_group_rules_required = try(var.settings.network_security_group_rules_required, null)
  customer_managed_key_enabled          = try(var.settings.customer_managed_key_enabled, null)

  dynamic "custom_parameters" {
    for_each = try(var.settings.custom_parameters, null) == null ? [] : [1]

    content {
      no_public_ip             = try(var.settings.custom_parameters.no_public_ip, false)
      vnet_address_prefix      = try(var.settings.custom_parameters.vnet_address_prefix, null)
      nat_gateway_name         = try(var.settings.custom_parameters.nat_gateway_name, null)
      public_ip_name           = try(var.settings.custom_parameters.public_ip_name, null)
      storage_account_name     = try(var.settings.custom_parameters.storage_account_name, null)
      storage_account_sku_name = try(var.settings.custom_parameters.storage_account_sku_name, null)

      # BUG opened on https://github.com/hashicorp/terraform-provider-azurerm/issues/13086
      # aml_workspace_id = try(coalesce(
      #   try(var.settings.custom_parameters.machine_learning.id, null),
      #   try(var.aml[var.client_config.landingzone_key][var.settings.custom_parameters.machine_learning.key].id, null),
      #   try(var.aml[var.settings.custom_parameters.machine_learning.lz_key][var.settings.custom_parameters.vnet_key][var.settings.custom_parameters.machine_learning.key].id, null),
      #   ),
      #   null
      # )

      virtual_network_id = try(coalesce(
        try(var.settings.custom_parameters.virtual_network_id, null),
        try(var.vnets[var.client_config.landingzone_key][var.settings.custom_parameters.vnet_key].id, null),
        try(var.vnets[var.settings.custom_parameters.lz_key][var.settings.custom_parameters.vnet_key].id, null),
        ),
        null
      )

      public_subnet_name = try(coalesce(
        try(var.settings.custom_parameters.public_subnet_name, null),
        try(var.vnets[var.client_config.landingzone_key][var.settings.custom_parameters.vnet_key].subnets[var.settings.custom_parameters.public_subnet_key].name, null),
        try(var.vnets[var.settings.custom_parameters.lz_key][var.settings.custom_parameters.vnet_key].subnets[var.settings.custom_parameters.public_subnet_key].name, null),
        ),
        null
      )

      #the NSG-association ID is the subnet-id, so it can be simplified:
      public_subnet_network_security_group_association_id = try(coalesce(
        try(var.settings.custom_parameters.public_subnet_network_security_group_association_id, null),
        try(var.vnets[var.client_config.landingzone_key][var.settings.custom_parameters.vnet_key].subnets[var.settings.custom_parameters.public_subnet_key].id, null),
        try(var.vnets[var.settings.custom_parameters.lz_key][var.settings.custom_parameters.vnet_key].subnets[var.settings.custom_parameters.public_subnet_key].id, null),
        ),
        null
      )

      private_subnet_name = try(coalesce(
        try(var.settings.custom_parameters.private_subnet_name, null),
        try(var.vnets[var.client_config.landingzone_key][var.settings.custom_parameters.vnet_key].subnets[var.settings.custom_parameters.private_subnet_key].name, null),
        try(var.vnets[var.settings.custom_parameters.lz_key][var.settings.custom_parameters.vnet_key].subnets[var.settings.custom_parameters.private_subnet_key].name, null),
        ),
        null
      )

      #the NSG-association ID is the subnet-id, so it can be simplified:
      private_subnet_network_security_group_association_id = try(coalesce(
        try(var.settings.custom_parameters.private_subnet_network_security_group_association_id, null),
        try(var.vnets[var.client_config.landingzone_key][var.settings.custom_parameters.vnet_key].subnets[var.settings.custom_parameters.public_subnet_key].id, null),
        try(var.vnets[var.settings.custom_parameters.lz_key][var.settings.custom_parameters.vnet_key].subnets[var.settings.custom_parameters.public_subnet_key].id, null),
        ),
        null
      )

    }
  }
}
