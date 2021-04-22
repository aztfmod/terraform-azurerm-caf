variable "global_settings" {
  default = {
    default_region = "region1"
    prefix         = null
    regions = {
      region1 = "southeastasia"
      region2 = "eastasia"
    }
  }
}

variable "landingzone" {
  default = {
    backend_type        = "azurerm"
    global_settings_key = "launchpad"
    level               = "level0"
    key                 = "examples"
  }
}

variable "var_folder_path" {
  default = {}
}

variable "provider_azurerm_features_keyvault" {
  default = {
    purge_soft_delete_on_destroy = true
  }
}

variable "environment" {
  default = "sandpit"
}
variable "rover_version" {
  default = null
}
variable "logged_user_objectId" {
  default = null
}
variable "logged_aad_app_objectId" {
  default = null
}
variable "tags" {
  default = null
  type    = map(any)
}
variable "app_service_environments" {
  default = {}
}
variable "app_service_plans" {
  default = {}
}
variable "app_services" {
  default = {}
}
variable "diagnostics_definition" {
  default = null
}
variable "resource_groups" {
  default = null
}
variable "network_security_group_definition" {
  default = {}
}
variable "route_tables" {
  default = {}
}
variable "azurerm_routes" {
  default = {}
}
variable "vnets" {
  default = {}
}
variable "azurerm_redis_caches" {
  default = {}
}
variable "mssql_servers" {
  default = {}
}
variable "mssql_managed_instances" {
  default = {}
}
variable "mssql_managed_instances_secondary" {
  default = {}
}
variable "mssql_databases" {
  default = {}
}
variable "mssql_managed_databases" {
  default = {}
}
variable "mssql_managed_databases_restore" {
  default = {}
}
variable "mssql_managed_databases_backup_ltr" {
  default = {}
}
variable "mssql_elastic_pools" {
  default = {}
}
variable "mariadb_servers" {
  default = {}
}
variable "mariadb_databases" {
  default = {}
}
variable "mssql_failover_groups" {
  default = {}
}
variable "mssql_mi_failover_groups" {
  default = {}
}
variable "mssql_mi_administrators" {
  default = {}
}
variable "mssql_mi_tdes" {
  default = {}
}
variable "mssql_mi_secondary_tdes" {
  default = {}
}
variable "storage_accounts" {
  default = {}
}
variable "azuread_groups" {
  default = {}
}
variable "azuread_roles" {
  default = {}
}
variable "keyvaults" {
  default = {}
}
variable "keyvault_access_policies" {
  default = {}
}
variable "keyvault_certificate_issuers" {
  default = {}
}
variable "keyvault_keys" {
  default = {}
}
variable "keyvault_certificate_requests" {
  default = {}
}
variable "keyvault_certificates" {
  default = {}
}
variable "virtual_machines" {
  default = {}
}
variable "bastion_hosts" {
  default = {}
}
variable "public_ip_addresses" {
  default = {}
}
variable "diagnostic_storage_accounts" {
  default = {}
}
variable "diagnostic_event_hub_namespaces" {
  default = {}
}
variable "diagnostic_log_analytics" {
  default = {}
}
variable "managed_identities" {
  default = {}
}
variable "private_dns" {
  default = {}
}
variable "synapse_workspaces" {
  default = {}
}
variable "azurerm_application_insights" {
  default = {}
}
variable "role_mapping" {
  default = {}
}
variable "aks_clusters" {
  default = {}
}
variable "azure_container_registries" {
  default = {}
}
variable "databricks_workspaces" {
  default = {}
}
variable "machine_learning_workspaces" {
  default = {}
}
variable "monitoring" {
  default = {}
}
variable "virtual_wans" {
  default = {}
}
variable "event_hub_namespaces" {
  default = {}
}
variable "application_gateways" {
  default = {}
}
variable "application_gateway_applications" {
  default = {}
}
variable "application_gateway_waf_policies" {
  default = {}
}
variable "mysql_servers" {
  default = {}
}
variable "postgresql_servers" {
  default = {}
}
variable "cosmos_db" {
  default = {}
}
variable "log_analytics" {
  default = {}
}
variable "recovery_vaults" {
  default = {}
}
variable "availability_sets" {
  default = {}
}
variable "proximity_placement_groups" {
  default = {}
}
variable "network_watchers" {
  default = {}
}
variable "virtual_network_gateways" {
  default = {}
}
variable "virtual_network_gateway_connections" {
  default = {}
}
variable "express_route_circuits" {
  default = {}
}
variable "express_route_circuit_authorizations" {
  default = {}
}

variable "shared_image_galleries" {
  default = {}
}

variable "image_definitions" {
  default = {}
}

variable "diagnostics_destinations" {
  default = {}
}
variable "vnet_peerings" {
  default = {}
}

variable "packer_service_principal" {
  default = {}
}

variable "packer_managed_identity" {
  default = {}
}

variable "azuread_api_permissions" {
  default = {}
}

variable "keyvault_access_policies_azuread_apps" {
  default = {}
}

variable "cosmos_dbs" {
  default = {}
}
variable "dynamic_keyvault_secrets" {
  default = {}
}
variable "front_doors" {
  default = {}
}
variable "front_door_waf_policies" {
  default = {}
}
variable "dns_zones" {
  default = {}
}
variable "dns_zone_records" {
  default = {}
}

variable "private_endpoints" {
  default = {}
}

variable "event_hubs" {
  default = {}
}
variable "automations" {
  default = {}
}

variable "local_network_gateways" {
  default = {}
}

variable "domain_name_registrations" {
  default = {}
}

variable "azuread_apps" {
  default = {}
  type    = map(any)
}
variable "azuread_users" {
  default = {}
  type    = map(any)
}
variable "custom_role_definitions" {
  default = {}
}
variable "azurerm_firewalls" {
  default = {}
}
variable "azurerm_firewall_network_rule_collection_definition" {
  default = {}
}
variable "azurerm_firewall_application_rule_collection_definition" {
  default = {}
}
variable "azurerm_firewall_nat_rule_collection_definition" {
  default = {}
}
variable "event_hub_auth_rules" {
  default = {}
}

variable "netapp_accounts" {
  default = {}
}

variable "load_balancers" {
  default = {}
}

variable "ip_groups" {
  default = {}
}
variable "container_groups" {
  default = {}
}
variable "event_hub_namespace_auth_rules" {
  default = {}
}
variable "event_hub_consumer_groups" {
  default = {}
}
variable "application_security_groups" {
  default = {}
}

variable "azurerm_firewall_policies" {
  default = {}
}

variable "azurerm_firewall_policy_rule_collection_groups" {
  default = {}
}
variable "disk_encryption_sets" {
  default = {}
}
variable "vhub_peerings" {
  default     = {}
  description = "Use virtual_hub_connections instead of vhub_peerings. It will be removed in version 6.0"
}
variable "virtual_hub_connections" {
  default = {}
}
variable "virtual_hub_route_tables" {
  default = {}
}
variable "virtual_hub_er_gateway_connections" {
  default = {}
}