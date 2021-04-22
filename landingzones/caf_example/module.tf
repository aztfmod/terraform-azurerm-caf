module "example" {
  source = "../.."

  azuread_apps                   = var.azuread_apps
  azuread_groups                 = var.azuread_groups
  azuread_roles                  = var.azuread_roles
  azuread_users                  = var.azuread_users
  current_landingzone_key        = var.landingzone.key
  custom_role_definitions        = var.custom_role_definitions
  event_hub_auth_rules           = var.event_hub_auth_rules
  event_hub_consumer_groups      = var.event_hub_consumer_groups
  event_hub_namespace_auth_rules = var.event_hub_namespace_auth_rules
  event_hub_namespaces           = var.event_hub_namespaces
  event_hubs                     = var.event_hubs
  global_settings                = var.global_settings
  keyvault_access_policies       = var.keyvault_access_policies
  keyvault_certificate_issuers   = var.keyvault_certificate_issuers
  keyvaults                      = var.keyvaults
  log_analytics                  = var.log_analytics
  logged_aad_app_objectId        = var.logged_aad_app_objectId
  logged_user_objectId           = var.logged_user_objectId
  managed_identities             = var.managed_identities
  resource_groups                = var.resource_groups
  role_mapping                   = var.role_mapping
  storage_accounts               = var.storage_accounts
  tags                           = local.tags

  webapp = {
    azurerm_application_insights = var.azurerm_application_insights
    app_service_environments     = var.app_service_environments
    app_service_plans            = var.app_service_plans
    app_services                 = var.app_services
  }
  compute = {
    aks_clusters               = var.aks_clusters
    aks_clusters               = var.aks_clusters
    availability_sets          = var.availability_sets
    azure_container_registries = var.azure_container_registries
    bastion_hosts              = var.bastion_hosts
    bastion_hosts              = var.bastion_hosts
    container_groups           = var.container_groups
    proximity_placement_groups = var.proximity_placement_groups
    virtual_machines           = var.virtual_machines
  }
  networking = {
    application_gateway_applications                        = var.application_gateway_applications
    application_gateway_waf_policies                        = var.application_gateway_waf_policies
    application_gateways                                    = var.application_gateways
    application_security_groups                             = var.application_security_groups
    azurerm_firewall_application_rule_collection_definition = var.azurerm_firewall_application_rule_collection_definition
    azurerm_firewall_nat_rule_collection_definition         = var.azurerm_firewall_nat_rule_collection_definition
    azurerm_firewall_network_rule_collection_definition     = var.azurerm_firewall_network_rule_collection_definition
    azurerm_firewall_policies                               = var.azurerm_firewall_policies
    azurerm_firewall_policy_rule_collection_groups          = var.azurerm_firewall_policy_rule_collection_groups
    azurerm_firewalls                                       = var.azurerm_firewalls
    azurerm_routes                                          = var.azurerm_routes
    dns_zone_records                                        = var.dns_zone_records
    dns_zones                                               = var.dns_zones
    domain_name_registrations                               = var.domain_name_registrations
    express_route_circuit_authorizations                    = var.express_route_circuit_authorizations
    express_route_circuits                                  = var.express_route_circuits
    front_door_waf_policies                                 = var.front_door_waf_policies
    front_doors                                             = var.front_doors
    ip_groups                                               = var.ip_groups
    load_balancers                                          = var.load_balancers
    local_network_gateways                                  = var.local_network_gateways
    network_security_group_definition                       = var.network_security_group_definition
    network_watchers                                        = var.network_watchers
    private_dns                                             = var.private_dns
    private_endpoints                                       = var.private_endpoints
    public_ip_addresses                                     = var.public_ip_addresses
    route_tables                                            = var.route_tables
    vhub_peerings                                           = var.vhub_peerings
    virtual_hub_connections                                 = var.virtual_hub_connections
    virtual_hub_er_gateway_connections                      = var.virtual_hub_er_gateway_connections
    virtual_hub_route_tables                                = var.virtual_hub_route_tables
    virtual_network_gateway_connections                     = var.virtual_network_gateway_connections
    virtual_network_gateways                                = var.virtual_network_gateways
    virtual_wans                                            = var.virtual_wans
    vnet_peerings                                           = var.vnet_peerings
    vnets                                                   = var.vnets
  }

  diagnostics = {
    diagnostic_event_hub_namespaces = var.diagnostic_event_hub_namespaces
    diagnostic_log_analytics        = var.diagnostic_log_analytics
    diagnostic_storage_accounts     = var.diagnostic_storage_accounts
  }

  database = {
    azurerm_redis_caches               = var.azurerm_redis_caches
    cosmos_dbs                         = var.cosmos_dbs
    databricks_workspaces              = var.databricks_workspaces
    machine_learning_workspaces        = var.machine_learning_workspaces
    mariadb_servers                    = var.mariadb_servers
    mssql_databases                    = var.mssql_databases
    mssql_elastic_pools                = var.mssql_elastic_pools
    mssql_failover_groups              = var.mssql_failover_groups
    mssql_managed_databases_backup_ltr = var.mssql_managed_databases_backup_ltr
    mssql_managed_databases_restore    = var.mssql_managed_databases_restore
    mssql_managed_instances            = var.mssql_managed_instances
    mssql_managed_instances_secondary  = var.mssql_managed_instances_secondary
    mssql_mi_administrators            = var.mssql_mi_administrators
    mssql_mi_failover_groups           = var.mssql_mi_failover_groups
    mssql_mi_secondary_tdes            = var.mssql_mi_secondary_tdes
    mssql_mi_tdes                      = var.mssql_mi_tdes
    mssql_servers                      = var.mssql_servers
    mysql_servers                      = var.mysql_servers
    postgresql_servers                 = var.postgresql_servers
    synapse_workspaces                 = var.synapse_workspaces
  }
  shared_services = {
    image_definitions        = var.image_definitions
    monitoring               = var.monitoring
    packer_managed_identity  = var.packer_managed_identity
    packer_service_principal = var.packer_service_principal
    recovery_vaults          = var.recovery_vaults
    shared_image_galleries   = var.shared_image_galleries
  }

  security = {
    disk_encryption_sets          = var.disk_encryption_sets
    dynamic_keyvault_secrets      = var.dynamic_keyvault_secrets
    keyvault_certificate_issuers  = var.keyvault_certificate_issuers
    keyvault_certificate_requests = var.keyvault_certificate_requests
    keyvault_keys                 = var.keyvault_keys
    keyvault_certificates         = var.keyvault_certificates
  }

  storage = {
    netapp_accounts = var.netapp_accounts
  }
}
