module "caf" {
  source = "../"

  global_settings              = var.global_settings
  diagnostics                  = local.remote.diagnostics
  current_landingzone_key      = var.landingzone.key
  tenant_id                    = var.tenant_id
  logged_user_objectId         = var.logged_user_objectId
  logged_aad_app_objectId      = var.logged_aad_app_objectId
  resource_groups              = var.resource_groups
  storage_accounts             = var.storage_accounts
  azuread_groups               = var.azuread_groups
  azuread_apps                 = var.azuread_apps
  azuread_users                = var.azuread_users
  azuread_roles                = var.azuread_roles
  tags                         = local.tags
  keyvaults                    = var.keyvaults
  keyvault_access_policies     = var.keyvault_access_policies
  keyvault_certificate_issuers = var.keyvault_certificate_issuers
  managed_identities           = var.managed_identities
  role_mapping                 = var.role_mapping
  custom_role_definitions      = var.custom_role_definitions
  log_analytics                = var.log_analytics
  event_hub_namespaces         = var.event_hub_namespaces

  webapp = {
    azurerm_application_insights = var.azurerm_application_insights
    app_service_environments     = var.app_service_environments
    app_service_plans            = var.app_service_plans
    app_services                 = var.app_services
  }
  compute = {
    virtual_machines           = var.virtual_machines
    bastion_hosts              = var.bastion_hosts
    aks_clusters               = var.aks_clusters
    availability_sets          = var.availability_sets
    virtual_machines           = var.virtual_machines
    bastion_hosts              = var.bastion_hosts
    aks_clusters               = var.aks_clusters
    proximity_placement_groups = var.proximity_placement_groups
  }
  networking = {
    vnets                                = var.vnets
    network_security_group_definition    = var.network_security_group_definition
    public_ip_addresses                  = var.public_ip_addresses
    route_tables                         = var.route_tables
    azurerm_routes                       = var.azurerm_routes
    private_dns                          = var.private_dns
    virtual_wans                         = var.virtual_wans
    application_gateways                 = var.application_gateways
    application_gateway_applications     = var.application_gateway_applications
    virtual_network_gateways             = var.virtual_network_gateways
    virtual_network_gateway_connections  = var.virtual_network_gateway_connections
    express_route_circuits               = var.express_route_circuits
    express_route_circuit_authorizations = var.express_route_circuit_authorizations
    network_watchers                     = var.network_watchers
    vnet_peerings                        = var.vnet_peerings
    front_doors                          = var.front_doors
    front_door_waf_policies              = var.front_door_waf_policies
    dns_zones                            = var.dns_zones
    private_endpoints                    = var.private_endpoints
    local_network_gateways               = var.local_network_gateways
    azurerm_firewalls                    = var.azurerm_firewalls
    azurerm_firewall_network_rule_collection_definition      = var.azurerm_firewall_network_rule_collection_definition
    azurerm_firewall_application_rule_collection_definition  = var.azurerm_firewall_application_rule_collection_definition
    azurerm_firewall_nat_rule_collection_definition          = var.azurerm_firewall_nat_rule_collection_definition

  }
  database = {
    azurerm_redis_caches              = var.azurerm_redis_caches
    cosmos_dbs                        = var.cosmos_dbs
    databricks_workspaces             = var.databricks_workspaces
    machine_learning_workspaces       = var.machine_learning_workspaces
    mariadb_servers                   = var.mariadb_servers
    mssql_servers                     = var.mssql_servers
    mssql_managed_instances           = var.mssql_managed_instances
    mssql_managed_instances_secondary = var.mssql_managed_instances_secondary
    mssql_databases                   = var.mssql_databases
    mssql_managed_databases           = var.mssql_managed_databases
    mssql_managed_databases_restore   = var.mssql_managed_databases_restore
    mssql_elastic_pools               = var.mssql_elastic_pools
    mssql_failover_groups             = var.mssql_failover_groups
    mssql_mi_failover_groups          = var.mssql_mi_failover_groups
    mssql_mi_administrators           = var.mssql_mi_administrators
    mysql_servers                     = var.mysql_servers
    postgresql_servers                = var.postgresql_servers
    synapse_workspaces                = var.synapse_workspaces
  }
  shared_services = {
    monitoring      = var.monitoring
    recovery_vaults = var.recovery_vaults
    automations     = var.automations
  }

  security = {
    dynamic_keyvault_secrets      = var.dynamic_keyvault_secrets
    keyvault_certificate_requests = var.keyvault_certificate_requests
  }

  remote_objects = {
    keyvaults = local.remote.keyvaults
  }
}
