module "example" {
  source = "../"

  providers = {
    azurerm.vhub = azurerm.vhub
  }

  current_landingzone_key               = var.landingzone.key
  custom_role_definitions               = var.custom_role_definitions
  event_hub_auth_rules                  = var.event_hub_auth_rules
  event_hub_consumer_groups             = var.event_hub_consumer_groups
  event_hub_namespace_auth_rules        = var.event_hub_namespace_auth_rules
  event_hub_namespaces                  = var.event_hub_namespaces
  event_hubs                            = var.event_hubs
  global_settings                       = var.global_settings
  keyvault_access_policies              = var.keyvault_access_policies
  keyvault_certificate_issuers          = var.keyvault_certificate_issuers
  keyvaults                             = var.keyvaults
  log_analytics                         = var.log_analytics
  logged_aad_app_objectId               = var.logged_aad_app_objectId
  logged_user_objectId                  = var.logged_user_objectId
  managed_identities                    = var.managed_identities
  resource_groups                       = var.resource_groups
  role_mapping                          = var.role_mapping
  storage_accounts                      = var.storage_accounts
  subscription_billing_role_assignments = var.subscription_billing_role_assignments
  resource_provider_registration        = var.resource_provider_registration
  tags                                  = local.tags

  azuread = {
    azuread_api_permissions             = var.azuread_api_permissions
    azuread_applications                = var.azuread_applications
    azuread_apps                        = var.azuread_apps
    azuread_credentials                 = var.azuread_credentials
    azuread_groups                      = var.azuread_groups
    azuread_groups_membership           = var.azuread_groups_membership
    azuread_credential_policies         = var.azuread_credential_policies
    azuread_roles                       = var.azuread_roles
    azuread_service_principal_passwords = var.azuread_service_principal_passwords
    azuread_service_principals          = var.azuread_service_principals
    azuread_users                       = var.azuread_users
  }
  # # Defaulted, you can declare an override if you dont target Azure public
  # cloud = {
  #   acrLoginServerEndpoint                      = var.acrLoginServerEndpoint
  #   attestationEndpoint                         = var.attestationEndpoint
  #   azureDatalakeAnalyticsCatalogAndJobEndpoint = var.azureDatalakeAnalyticsCatalogAndJobEndpoint
  #   azureDatalakeStoreFileSystemEndpoint        = var.azureDatalakeStoreFileSystemEndpoint
  #   keyvaultDns                                 = var.keyvaultDns
  #   mariadbServerEndpoint                       = var.mariadbServerEndpoint
  #   mhsmDns                                     = var.mhsmDns
  #   mysqlServerEndpoint                         = var.mysqlServerEndpoint
  #   postgresqlServerEndpoint                    = var.postgresqlServerEndpoint
  #   sqlServerHostname                           = var.sqlServerHostname
  #   storageEndpoint                             = var.storageEndpoint
  #   storageSyncEndpoint                         = var.storageSyncEndpoint
  #   synapseAnalyticsEndpoint                    = var.synapseAnalyticsEndpoint
  #   activeDirectory                             = var.activeDirectory
  #   activeDirectoryDataLakeResourceId           = var.activeDirectoryDataLakeResourceId
  #   activeDirectoryGraphResourceId              = var.activeDirectoryGraphResourceId
  #   activeDirectoryResourceId                   = var.activeDirectoryResourceId
  #   appInsightsResourceId                       = var.appInsightsResourceId
  #   appInsightsTelemetryChannelResourceId       = var.appInsightsTelemetryChannelResourceId
  #   attestationResourceId                       = var.attestationResourceId
  #   azmirrorStorageAccountResourceId            = var.azmirrorStorageAccountResourceId
  #   batchResourceId                             = var.batchResourceId
  #   gallery                                     = var.gallery
  #   logAnalyticsResourceId                      = var.logAnalyticsResourceId
  #   management                                  = var.management
  #   mediaResourceId                             = var.mediaResourceId
  #   microsoftGraphResourceId                    = var.microsoftGraphResourceId
  #   ossrdbmsResourceId                          = var.ossrdbmsResourceId
  #   portal                                      = var.portal
  #   resourceManager                             = var.resourceManager
  #   sqlManagement                               = var.sqlManagement
  #   synapseAnalyticsResourceId                  = var.synapseAnalyticsResourceId
  #   vmImageAliasDoc                             = var.vmImageAliasDoc
  # }

  cognitive_services = {
    cognitive_services_account = var.cognitive_services_account
  }
  communication = {
    communication_services = var.communication_services
  }
  compute = {
    aks_clusters                        = var.aks_clusters
    aro_clusters                        = var.aro_clusters
    availability_sets                   = var.availability_sets
    azure_container_registries          = var.azure_container_registries
    batch_accounts                      = var.batch_accounts
    batch_applications                  = var.batch_applications
    batch_certificates                  = var.batch_certificates
    batch_jobs                          = var.batch_jobs
    batch_pools                         = var.batch_pools
    bastion_hosts                       = var.bastion_hosts
    container_groups                    = var.container_groups
    dedicated_host_groups               = var.dedicated_host_groups
    dedicated_hosts                     = var.dedicated_hosts
    machine_learning_compute_instance   = var.machine_learning_compute_instance
    proximity_placement_groups          = var.proximity_placement_groups
    runbooks                            = var.runbooks
    virtual_machine_scale_sets          = var.virtual_machine_scale_sets
    virtual_machines                    = var.virtual_machines
    vmware_private_clouds               = var.vmware_private_clouds
    vmware_clusters                     = var.vmware_clusters
    vmware_express_route_authorizations = var.vmware_express_route_authorizations
    wvd_applications                    = var.wvd_applications
    wvd_application_groups              = var.wvd_application_groups
    wvd_host_pools                      = var.wvd_host_pools
    wvd_workspaces                      = var.wvd_workspaces
  }
  diagnostics = {
    diagnostic_event_hub_namespaces = var.diagnostic_event_hub_namespaces
    diagnostic_log_analytics        = var.diagnostic_log_analytics
    diagnostic_storage_accounts     = var.diagnostic_storage_accounts
    diagnostics_definition          = var.diagnostics_definition
    diagnostics_destinations        = var.diagnostics_destinations
  }
  database = {
    app_config                         = var.app_config
    azurerm_redis_caches               = var.azurerm_redis_caches
    cosmos_dbs                         = var.cosmos_dbs
    cosmosdb_sql_databases             = var.cosmosdb_sql_databases
    databricks_workspaces              = var.databricks_workspaces
    database_migration_services        = var.database_migration_services
    database_migration_projects        = var.database_migration_projects
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
    postgresql_flexible_servers        = var.postgresql_flexible_servers
    postgresql_servers                 = var.postgresql_servers
    synapse_workspaces                 = var.synapse_workspaces
    mysql_flexible_server              = var.mysql_flexible_server
    data_explorer = {
      kusto_clusters                         = var.kusto_clusters
      kusto_databases                        = var.kusto_databases
      kusto_attached_database_configurations = var.kusto_attached_database_configurations
      kusto_cluster_customer_managed_keys    = var.kusto_cluster_customer_managed_keys
      kusto_cluster_principal_assignments    = var.kusto_cluster_principal_assignments
      kusto_database_principal_assignments   = var.kusto_database_principal_assignments
      kusto_eventgrid_data_connections       = var.kusto_eventgrid_data_connections
      kusto_eventhub_data_connections        = var.kusto_eventhub_data_connections
      kusto_iothub_data_connections          = var.kusto_iothub_data_connections
    }
  }
  data_protection = {
    backup_vaults          = var.backup_vaults
    backup_vault_policies  = var.backup_vault_policies
    backup_vault_instances = var.backup_vault_instances
  }
  messaging = {
    signalr_services             = var.signalr_services
    servicebus_namespaces        = var.servicebus_namespaces
    servicebus_topics            = var.servicebus_topics
    servicebus_queues            = var.servicebus_queues
    eventgrid_domain             = var.eventgrid_domain
    eventgrid_topic              = var.eventgrid_topic
    eventgrid_event_subscription = var.eventgrid_event_subscription
    eventgrid_domain_topic       = var.eventgrid_domain_topic
  }
  networking = {
    application_gateway_applications                        = var.application_gateway_applications
    application_gateway_applications_v1                     = var.application_gateway_applications_v1
    application_gateway_platforms                           = var.application_gateway_platforms
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
    cdn_profile                                             = var.cdn_profile
    cdn_endpoint                                            = var.cdn_endpoint
    dns_zone_records                                        = var.dns_zone_records
    dns_zones                                               = var.dns_zones
    domain_name_registrations                               = var.domain_name_registrations
    express_route_circuit_authorizations                    = var.express_route_circuit_authorizations
    express_route_circuits                                  = var.express_route_circuits
    front_door_waf_policies                                 = var.front_door_waf_policies
    front_doors                                             = var.front_doors
    frontdoor_rules_engine                                  = var.frontdoor_rules_engine
    frontdoor_custom_https_configuration                    = var.frontdoor_custom_https_configuration
    ip_groups                                               = var.ip_groups
    lb                                                      = var.lb
    lb_backend_address_pool                                 = var.lb_backend_address_pool
    lb_backend_address_pool_address                         = var.lb_backend_address_pool_address
    lb_nat_pool                                             = var.lb_nat_pool
    lb_nat_rule                                             = var.lb_nat_rule
    lb_outbound_rule                                        = var.lb_outbound_rule
    lb_probe                                                = var.lb_probe
    lb_rule                                                 = var.lb_rule
    load_balancers                                          = var.load_balancers
    local_network_gateways                                  = var.local_network_gateways
    nat_gateways                                            = var.nat_gateways
    network_interface_backend_address_pool_association      = var.network_interface_backend_address_pool_association
    network_security_group_definition                       = var.network_security_group_definition
    network_watchers                                        = var.network_watchers
    private_dns                                             = var.private_dns
    private_dns_vnet_links                                  = var.private_dns_vnet_links
    private_endpoints                                       = var.private_endpoints
    public_ip_addresses                                     = var.public_ip_addresses
    relay_namespace                                         = var.relay_namespace
    relay_hybrid_connection                                 = var.relay_hybrid_connection
    public_ip_prefixes                                      = var.public_ip_prefixes
    route_tables                                            = var.route_tables
    traffic_manager_profile                                 = var.traffic_manager_profile
    traffic_manager_nested_endpoint                         = var.traffic_manager_nested_endpoint
    traffic_manager_external_endpoint                       = var.traffic_manager_external_endpoint
    traffic_manager_azure_endpoint                          = var.traffic_manager_azure_endpoint
    vhub_peerings                                           = var.vhub_peerings
    virtual_hub_connections                                 = var.virtual_hub_connections
    virtual_hub_er_gateway_connections                      = var.virtual_hub_er_gateway_connections
    virtual_hub_route_table_routes                          = var.virtual_hub_route_table_routes
    virtual_hub_route_tables                                = var.virtual_hub_route_tables
    virtual_hubs                                            = var.virtual_hubs
    virtual_network_gateway_connections                     = var.virtual_network_gateway_connections
    virtual_network_gateways                                = var.virtual_network_gateways
    virtual_wans                                            = var.virtual_wans
    vnet_peerings                                           = var.vnet_peerings
    vnet_peerings_v1                                        = var.vnet_peerings_v1
    vnets                                                   = var.vnets
    virtual_subnets                                         = var.virtual_subnets
    vpn_gateway_connections                                 = var.vpn_gateway_connections
    vpn_sites                                               = var.vpn_sites
  }

  security = {
    disk_encryption_sets                = var.disk_encryption_sets
    dynamic_keyvault_secrets            = var.dynamic_keyvault_secrets
    keyvault_certificate_issuers        = var.keyvault_certificate_issuers
    keyvault_certificate_requests       = var.keyvault_certificate_requests
    keyvault_keys                       = var.keyvault_keys
    keyvault_certificates               = var.keyvault_certificates
    lighthouse_definitions              = var.lighthouse_definitions
    sentinel                            = var.sentinel
    sentinel_automation_rules           = var.sentinel_automation_rules
    sentinel_watchlists                 = var.sentinel_watchlists
    sentinel_watchlist_items            = var.sentinel_watchlist_items
    sentinel_ar_fusions                 = var.sentinel_ar_fusions
    sentinel_ar_ml_behavior_analytics   = var.sentinel_ar_ml_behavior_analytics
    sentinel_ar_ms_security_incidents   = var.sentinel_ar_ms_security_incidents
    sentinel_ar_scheduled               = var.sentinel_ar_scheduled
    sentinel_dc_aad                     = var.sentinel_dc_aad
    sentinel_dc_app_security            = var.sentinel_dc_app_security
    sentinel_dc_aws                     = var.sentinel_dc_aws
    sentinel_dc_azure_threat_protection = var.sentinel_dc_azure_threat_protection
    sentinel_dc_ms_threat_protection    = var.sentinel_dc_ms_threat_protection
    sentinel_dc_office_365              = var.sentinel_dc_office_365
    sentinel_dc_security_center         = var.sentinel_dc_security_center
    sentinel_dc_threat_intelligence     = var.sentinel_dc_threat_intelligence

  }

  shared_services = {
    automations                    = var.automations
    automation_schedules           = var.automation_schedules
    automation_runbooks            = var.automation_runbooks
    automation_log_analytics_links = var.automation_log_analytics_links
    consumption_budgets            = var.consumption_budgets
    image_definitions              = var.image_definitions
    log_analytics_storage_insights = var.log_analytics_storage_insights
    monitor_action_groups          = var.monitor_action_groups
    monitor_autoscale_settings     = var.monitor_autoscale_settings
    monitoring                     = var.monitoring
    monitor_metric_alert           = var.monitor_metric_alert
    monitor_activity_log_alert     = var.monitor_activity_log_alert
    packer_build                   = var.packer_build
    packer_service_principal       = var.packer_service_principal
    recovery_vaults                = var.recovery_vaults
    shared_image_galleries         = var.shared_image_galleries
  }
  storage = {
    netapp_accounts        = var.netapp_accounts
    storage_account_blobs  = var.storage_account_blobs
    storage_account_queues = var.storage_account_queues
    storage_containers     = var.storage_containers

  }
  webapp = {
    azurerm_application_insights = var.azurerm_application_insights
    app_service_environments     = var.app_service_environments
    app_service_environments_v3  = var.app_service_environments_v3
    app_service_plans            = var.app_service_plans
    app_services                 = var.app_services
    function_apps                = var.function_apps
    static_sites                 = var.static_sites
  }
  data_factory = {
    data_factory                                 = var.data_factory
    data_factory_pipeline                        = var.data_factory_pipeline
    data_factory_trigger_schedule                = var.data_factory_trigger_schedule
    data_factory_integration_runtime_azure_ssis  = var.data_factory_integration_runtime_azure_ssis
    data_factory_integration_runtime_self_hosted = var.data_factory_integration_runtime_self_hosted
    datasets = {
      azure_blob                          = var.data_factory_dataset_azure_blob
      cosmosdb_sqlapi                     = var.data_factory_dataset_cosmosdb_sqlapi
      delimited_text                      = var.data_factory_dataset_delimited_text
      http                                = var.data_factory_dataset_http
      json                                = var.data_factory_dataset_json
      mysql                               = var.data_factory_dataset_mysql
      postgresql                          = var.data_factory_dataset_postgresql
      sql_server_table                    = var.data_factory_dataset_sql_server_table
      data_factory_dataset_delimited_text = var.data_factory_dataset_delimited_text
    }
    linked_services = {
      azure_blob_storage = var.data_factory_linked_service_azure_blob_storage
      cosmosdb           = var.data_factory_linked_service_cosmosdb
      web                = var.data_factory_linked_service_web
      mysql              = var.data_factory_linked_service_mysql
      postgresql         = var.data_factory_linked_service_postgresql
      sql_server         = var.data_factory_linked_service_sql_server
      azure_databricks   = var.data_factory_linked_service_azure_databricks
    }
  }
  logic_app = {
    integration_service_environment = var.integration_service_environment
    logic_app_action_custom         = var.logic_app_action_custom
    logic_app_action_http           = var.logic_app_action_http
    logic_app_integration_account   = var.logic_app_integration_account
    # logic_app_integration_account_certificate  = var.logic_app_integration_account_certificate
    # logic_app_integration_account_session  = var.logic_app_integration_account_session
    logic_app_trigger_custom       = var.logic_app_trigger_custom
    logic_app_trigger_http_request = var.logic_app_trigger_http_request
    logic_app_trigger_recurrence   = var.logic_app_trigger_recurrence
    logic_app_workflow             = var.logic_app_workflow
  }
  identity = {
    active_directory_domain_service             = var.active_directory_domain_service
    active_directory_domain_service_replica_set = var.active_directory_domain_service_replica_set
  }
  apim = {
    api_management                      = var.api_management
    api_management_api                  = var.api_management_api
    api_management_api_diagnostic       = var.api_management_api_diagnostic
    api_management_logger               = var.api_management_logger
    api_management_api_operation        = var.api_management_api_operation
    api_management_backend              = var.api_management_backend
    api_management_api_policy           = var.api_management_api_policy
    api_management_api_operation_tag    = var.api_management_api_operation_tag
    api_management_api_operation_policy = var.api_management_api_operation_policy
    api_management_user                 = var.api_management_user
    api_management_custom_domain        = var.api_management_custom_domain
    api_management_diagnostic           = var.api_management_diagnostic
    api_management_certificate          = var.api_management_certificate
    api_management_gateway              = var.api_management_gateway
    api_management_gateway_api          = var.api_management_gateway_api
    api_management_group                = var.api_management_group
    api_management_subscription         = var.api_management_subscription
    api_management_product              = var.api_management_product
  }
  purview = {
    purview_accounts = var.purview_accounts
  }

  iot = {
    digital_twins_instances             = var.digital_twins_instances
    digital_twins_endpoint_eventhubs    = var.digital_twins_endpoint_eventhubs
    digital_twins_endpoint_eventgrids   = var.digital_twins_endpoint_eventgrids
    digital_twins_endpoint_servicebuses = var.digital_twins_endpoint_servicebuses

  }
  search_services = {
    search_services = var.search_services
  }
}
