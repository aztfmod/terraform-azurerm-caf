locals {
  # CAF landing zones can retrieve remote objects from a different landing zone and the
  # combined_objects will merge it with the local objects
  combined_objects_aks_clusters                                   = merge(tomap({ (local.client_config.landingzone_key) = module.aks_clusters }), try(var.remote_objects.aks_clusters, {}))
  combined_objects_api_management                                 = merge(tomap({ (local.client_config.landingzone_key) = module.api_management }), try(var.remote_objects.api_management, {}))
  combined_objects_api_management_api                             = merge(tomap({ (local.client_config.landingzone_key) = module.api_management_api }), try(var.remote_objects.api_management_api, {}))
  combined_objects_api_management_api_operation                   = merge(tomap({ (local.client_config.landingzone_key) = module.api_management_api_operation }), try(var.remote_objects.api_management_api_operation, {}))
  combined_objects_api_management_gateway                         = merge(tomap({ (local.client_config.landingzone_key) = module.api_management_gateway }), try(var.remote_objects.api_management_gateway, {}))
  combined_objects_api_management_logger                          = merge(tomap({ (local.client_config.landingzone_key) = module.api_management_logger }), try(var.remote_objects.api_management_logger, {}))
  combined_objects_app_config                                     = merge(tomap({ (local.client_config.landingzone_key) = module.app_config }), try(var.remote_objects.app_config, {}))
  combined_objects_app_service_environments                       = merge(tomap({ (local.client_config.landingzone_key) = module.app_service_environments }), try(var.remote_objects.app_service_environments, {}))
  combined_objects_app_service_plans                              = merge(tomap({ (local.client_config.landingzone_key) = module.app_service_plans }), try(var.remote_objects.app_service_plans, {}))
  combined_objects_app_services                                   = merge(tomap({ (local.client_config.landingzone_key) = module.app_services }), try(var.remote_objects.app_services, {}))
  combined_objects_application_gateway_platforms                  = merge(tomap({ (local.client_config.landingzone_key) = module.application_gateway_platforms }), try(var.remote_objects.application_gateway_platforms, {}))
  combined_objects_application_gateway_waf_policies               = merge(tomap({ (local.client_config.landingzone_key) = module.application_gateway_waf_policies }), try(var.remote_objects.application_gateway_waf_policies, {}))
  combined_objects_application_gateways                           = merge(tomap({ (local.client_config.landingzone_key) = module.application_gateways }), try(var.remote_objects.application_gateways, {}))
  combined_objects_application_insights                           = merge(tomap({ (local.client_config.landingzone_key) = module.azurerm_application_insights }), try(var.remote_objects.azurerm_application_insights, {}))
  combined_objects_application_security_groups                    = merge(tomap({ (local.client_config.landingzone_key) = module.application_security_groups }), try(var.remote_objects.application_security_groups, {}))
  combined_objects_availability_sets                              = merge(tomap({ (local.client_config.landingzone_key) = module.availability_sets }), try(var.remote_objects.availability_sets, {}))
  combined_objects_azure_container_registries                     = merge(tomap({ (local.client_config.landingzone_key) = module.container_registry }), try(var.remote_objects.container_registry, {}))
  combined_objects_cosmos_dbs                                     = merge(tomap({ (local.client_config.landingzone_key) = module.cosmos_dbs }), try(var.remote_objects.cosmos_dbs, {}))
  combined_objects_cosmosdb_sql_databases                         = merge(tomap({ (local.client_config.landingzone_key) = module.cosmosdb_sql_databases }), try(var.remote_objects.cosmosdb_sql_databases, {}))
  combined_objects_azuread_applications                           = merge(tomap({ (local.client_config.landingzone_key) = module.azuread_applications_v1 }), try(var.remote_objects.azuread_applications, {}))
  combined_objects_azuread_apps                                   = merge(tomap({ (local.client_config.landingzone_key) = module.azuread_applications }), try(var.remote_objects.azuread_apps, {}))
  combined_objects_azuread_groups                                 = merge(tomap({ (local.client_config.landingzone_key) = module.azuread_groups }), try(var.remote_objects.azuread_groups, {}))
  combined_objects_azuread_service_principals                     = merge(tomap({ (local.client_config.landingzone_key) = module.azuread_service_principals }), try(var.remote_objects.azuread_service_principals, {}))
  combined_objects_azuread_users                                  = merge(tomap({ (local.client_config.landingzone_key) = module.azuread_users }), try(var.remote_objects.azuread_users, {}))
  combined_objects_azurerm_firewall_policies                      = merge(tomap({ (local.client_config.landingzone_key) = module.azurerm_firewall_policies }), try(var.remote_objects.azurerm_firewall_policies, {}))
  combined_objects_azurerm_firewalls                              = merge(tomap({ (local.client_config.landingzone_key) = module.azurerm_firewalls }), try(var.remote_objects.azurerm_firewalls, {}))
  combined_objects_cdn_profile                                    = merge(tomap({ (local.client_config.landingzone_key) = module.cdn_profile }), try(var.remote_objects.cdn_profile, {}))
  combined_objects_cognitive_services_accounts                    = merge(tomap({ (local.client_config.landingzone_key) = module.cognitive_services_account }), try(var.remote_objects.cognitive_services_account, {}))
  combined_objects_consumption_budgets_resource_groups            = merge(tomap({ (local.client_config.landingzone_key) = module.consumption_budgets_resource_groups }), try(var.remote_objects.consumption_budgets_resource_groups, {}))
  combined_objects_consumption_budgets_subscriptions              = merge(tomap({ (local.client_config.landingzone_key) = module.consumption_budgets_subscriptions }), try(var.remote_objects.consumption_budgets_subscriptions, {}))
  combined_objects_container_registry                             = merge(tomap({ (local.client_config.landingzone_key) = module.container_registry }), try(var.remote_objects.container_registry, {}))
  combined_objects_databricks_workspaces                          = merge(tomap({ (local.client_config.landingzone_key) = module.databricks_workspaces }), try(var.remote_objects.databricks_workspaces, {}))
  combined_objects_data_factory                                   = merge(tomap({ (local.client_config.landingzone_key) = module.data_factory }), try(var.remote_objects.data_factory, {}))
  combined_objects_data_factory_integration_runtime_azure_ssis    = merge(tomap({ (local.client_config.landingzone_key) = module.data_factory_integration_runtime_azure_ssis }), try(var.remote_objects.combined_objects_data_factory_integration_runtime_azure_ssis, {}))
  combined_objects_data_factory_linked_service_azure_blob_storage = merge(tomap({ (local.client_config.landingzone_key) = module.data_factory_linked_service_azure_blob_storage }), try(var.remote_objects.data_factory_linked_service_azure_blob_storage, {}))
  combined_objects_data_factory_linked_service_cosmosdb           = merge(tomap({ (local.client_config.landingzone_key) = module.data_factory_linked_service_cosmosdb }), try(var.remote_objects.data_factory_linked_service_cosmosdb, {}))
  combined_objects_data_factory_linked_service_mysql              = merge(tomap({ (local.client_config.landingzone_key) = module.data_factory_linked_service_mysql }), try(var.remote_objects.data_factory_linked_service_mysql, {}))
  combined_objects_data_factory_linked_service_postgresql         = merge(tomap({ (local.client_config.landingzone_key) = module.data_factory_linked_service_postgresql }), try(var.remote_objects.data_factory_linked_service_postgresql, {}))
  combined_objects_data_factory_linked_service_sql_server         = merge(tomap({ (local.client_config.landingzone_key) = module.data_factory_linked_service_sql_server }), try(var.remote_objects.data_factory_linked_service_sql_server, {}))
  combined_objects_data_factory_linked_service_web                = merge(tomap({ (local.client_config.landingzone_key) = module.data_factory_linked_service_web }), try(var.remote_objects.data_factory_linked_service_web, {}))
  combined_objects_data_factory_pipeline                          = merge(tomap({ (local.client_config.landingzone_key) = module.data_factory_pipeline }), try(var.remote_objects.data_factory_pipeline, {}))
  combined_objects_data_factory_integration_runtime_self_hosted   = merge(tomap({ (local.client_config.landingzone_key) = module.data_factory_integration_runtime_self_hosted }), try(var.remote_objects.data_factory_integration_runtime_self_hosted, {}))
  combined_objects_database_migration_services                    = merge(tomap({ (local.client_config.landingzone_key) = module.database_migration_services }), try(var.remote_objects.database_migration_services, {}))
  combined_objects_dedicated_host_groups                          = merge(tomap({ (local.client_config.landingzone_key) = module.dedicated_host_groups }), try(var.remote_objects.dedicated_host_groups, {}))
  combined_objects_dedicated_hosts                                = merge(tomap({ (local.client_config.landingzone_key) = module.dedicated_hosts }), try(var.remote_objects.dedicated_hosts, {}))
  combined_objects_diagnostic_storage_accounts                    = merge(tomap({ (local.client_config.landingzone_key) = module.diagnostic_storage_accounts }), try(var.remote_objects.diagnostic_storage_accounts, {}))
  combined_objects_disk_encryption_sets                           = merge(tomap({ (local.client_config.landingzone_key) = module.disk_encryption_sets }), try(var.remote_objects.disk_encryption_sets, {}))
  combined_objects_domain_name_registrations                      = merge(tomap({ (local.client_config.landingzone_key) = module.domain_name_registrations }), try(var.remote_objects.domain_name_registrations, {}))
  combined_objects_dns_zones                                      = merge(tomap({ (local.client_config.landingzone_key) = module.dns_zones }), try(var.remote_objects.dns_zones, {}))
  combined_objects_ddos_services                                  = merge(tomap({ (local.client_config.landingzone_key) = azurerm_network_ddos_protection_plan.ddos_protection_plan }), try(var.remote_objects.ddos_services, {}), try(var.remote_objects.ddos_services, {}))
  combined_objects_eventgrid_domains                              = merge(tomap({ (local.client_config.landingzone_key) = module.eventgrid_domain }), try(var.remote_objects.eventgrid_domain, {}))
  combined_objects_event_hubs                                     = merge(tomap({ (local.client_config.landingzone_key) = module.event_hubs }), try(var.remote_objects.event_hubs, {}))
  combined_objects_event_hub_namespaces                           = merge(tomap({ (local.client_config.landingzone_key) = module.event_hub_namespaces }), try(var.remote_objects.event_hub_namespaces, {}))
  combined_objects_express_route_circuit_authorizations           = merge(tomap({ (local.client_config.landingzone_key) = module.express_route_circuit_authorizations }), try(var.remote_objects.express_route_circuit_authorizations, {}))
  combined_objects_express_route_circuit_peerings                 = merge(tomap({ (local.client_config.landingzone_key) = module.express_route_circuit_peerings }), try(var.remote_objects.express_route_circuit_peerings, {}))
  combined_objects_express_route_circuits                         = merge(tomap({ (local.client_config.landingzone_key) = module.express_route_circuits }), try(var.remote_objects.express_route_circuits, {}))
  combined_objects_front_door                                     = merge(tomap({ (local.client_config.landingzone_key) = module.front_doors }), try(var.remote_objects.front_doors, {}))
  combined_objects_front_door_waf_policies                        = merge(tomap({ (local.client_config.landingzone_key) = module.front_door_waf_policies }), try(var.remote_objects.front_door_waf_policies, {}))
  combined_objects_function_apps                                  = merge(tomap({ (local.client_config.landingzone_key) = module.function_apps }), try(var.remote_objects.function_apps, {}))
  combined_objects_image_definitions                              = merge(tomap({ (local.client_config.landingzone_key) = module.image_definitions }), try(var.remote_objects.image_definitions, {}))
  combined_objects_integration_service_environment                = merge(tomap({ (local.client_config.landingzone_key) = module.integration_service_environment }), try(var.remote_objects.integration_service_environment, {}))
  combined_objects_keyvault_certificates                          = merge(tomap({ (local.client_config.landingzone_key) = module.keyvault_certificates }), try(var.remote_objects.keyvault_certificates, {}))
  combined_objects_keyvault_certificate_requests                  = merge(tomap({ (local.client_config.landingzone_key) = module.keyvault_certificate_requests }), try(var.remote_objects.keyvault_certificate_requests, {}))
  combined_objects_keyvault_keys                                  = merge(tomap({ (local.client_config.landingzone_key) = module.keyvault_keys }), try(var.remote_objects.keyvault_keys, {}))
  combined_objects_keyvaults                                      = merge(tomap({ (local.client_config.landingzone_key) = module.keyvaults }), try(var.remote_objects.keyvaults, {}))
  combined_objects_kusto_clusters                                 = merge(tomap({ (local.client_config.landingzone_key) = module.kusto_clusters }), try(var.remote_objects.kusto_clusters, {}))
  combined_objects_kusto_databases                                = merge(tomap({ (local.client_config.landingzone_key) = module.kusto_databases }), try(var.remote_objects.kusto_databases, {}))
  combined_objects_lb                                             = merge(tomap({ (local.client_config.landingzone_key) = module.lb }), try(var.remote_objects.lb, {}))
  combined_objects_lb_backend_address_pool                        = merge(tomap({ (local.client_config.landingzone_key) = module.lb_backend_address_pool }), try(var.remote_objects.lb_backend_address_pool, {}))
  combined_objects_load_balancers                                 = merge(tomap({ (local.client_config.landingzone_key) = module.load_balancers }), try(var.remote_objects.load_balancers, {}))
  combined_objects_log_analytics                                  = merge(tomap({ (local.client_config.landingzone_key) = module.log_analytics }), try(var.remote_objects.log_analytics, {}))
  combined_objects_logic_app_integration_account                  = merge(tomap({ (local.client_config.landingzone_key) = module.logic_app_integration_account }), try(var.remote_objects.logic_app_integration_account, {}))
  combined_objects_logic_app_workflow                             = merge(tomap({ (local.client_config.landingzone_key) = module.logic_app_workflow }), try(var.remote_objects.logic_app_workflow, {}))
  combined_objects_machine_learning                               = merge(tomap({ (local.client_config.landingzone_key) = module.machine_learning_workspaces }), try(var.remote_objects.machine_learning_workspaces, {}))
  combined_objects_managed_identities                             = merge(tomap({ (local.client_config.landingzone_key) = module.managed_identities }), try(var.remote_objects.managed_identities, {}))
  combined_objects_monitor_action_groups                          = merge(tomap({ (local.client_config.landingzone_key) = module.monitor_action_groups }), try(var.remote_objects.monitor_action_groups, {}))
  combined_objects_mysql_flexible_server                          = merge(tomap({ (local.client_config.landingzone_key) = module.mysql_flexible_server }), try(var.remote_objects.mysql_flexible_server, {}))
  combined_objects_mssql_databases                                = merge(tomap({ (local.client_config.landingzone_key) = module.mssql_databases }), try(var.remote_objects.mssql_databases, {}))
  combined_objects_mssql_elastic_pools                            = merge(tomap({ (local.client_config.landingzone_key) = module.mssql_elastic_pools }), try(var.remote_objects.mssql_elastic_pools, {}))
  combined_objects_mssql_managed_databases                        = merge(tomap({ (local.client_config.landingzone_key) = module.mssql_managed_databases }), try(var.remote_objects.mssql_managed_databases, {}))
  combined_objects_mssql_managed_instances                        = merge(tomap({ (local.client_config.landingzone_key) = module.mssql_managed_instances }), try(var.remote_objects.mssql_managed_instances, {}))
  combined_objects_mssql_managed_instances_secondary              = merge(tomap({ (local.client_config.landingzone_key) = module.mssql_managed_instances_secondary }), try(var.remote_objects.mssql_managed_instances_secondary, {}))
  combined_objects_mssql_servers                                  = merge(tomap({ (local.client_config.landingzone_key) = module.mssql_servers }), try(var.remote_objects.mssql_servers, {}))
  combined_objects_mysql_servers                                  = merge(tomap({ (local.client_config.landingzone_key) = module.mysql_servers }), try(var.remote_objects.mysql_servers, {}))
  combined_objects_nat_gateways                                   = merge(tomap({ (local.client_config.landingzone_key) = module.nat_gateways }), try(var.remote_objects.nat_gateways, {}))
  combined_objects_network_profiles                               = merge(tomap({ (local.client_config.landingzone_key) = module.network_profiles }), try(var.remote_objects.network_profiles, {}))
  combined_objects_network_security_groups                        = merge(tomap({ (local.client_config.landingzone_key) = module.network_security_groups }), try(var.remote_objects.network_security_groups, {}))
  combined_objects_network_watchers                               = merge(tomap({ (local.client_config.landingzone_key) = module.network_watchers }), try(var.remote_objects.network_watchers, {}))
  combined_objects_networking                                     = merge(tomap({ (local.client_config.landingzone_key) = module.networking }), try(var.remote_objects.vnets, {}))
  combined_objects_postgresql_flexible_servers                    = merge(tomap({ (local.client_config.landingzone_key) = module.postgresql_flexible_servers }), try(var.remote_objects.postgresql_flexible_servers, {}))
  combined_objects_postgresql_servers                             = merge(tomap({ (local.client_config.landingzone_key) = module.postgresql_servers }), try(var.remote_objects.postgresql_servers, {}))
  combined_objects_private_dns                                    = merge(tomap({ (local.client_config.landingzone_key) = module.private_dns }), try(var.remote_objects.private_dns, {}))
  combined_objects_private_endpoints                              = merge(tomap({ (local.client_config.landingzone_key) = module.private_endpoints }), try(var.remote_objects.private_endpoints, {}))
  combined_objects_purview_accounts                               = merge(tomap({ (local.client_config.landingzone_key) = module.purview_accounts }), try(var.remote_objects.purview_accounts, {}))
  combined_objects_proximity_placement_groups                     = merge(tomap({ (local.client_config.landingzone_key) = module.proximity_placement_groups }), try(var.remote_objects.proximity_placement_groups, {}))
  combined_objects_public_ip_addresses                            = merge(tomap({ (local.client_config.landingzone_key) = module.public_ip_addresses }), try(var.remote_objects.public_ip_addresses, {}))
  combined_objects_public_ip_prefixes                             = merge(tomap({ (local.client_config.landingzone_key) = module.public_ip_prefixes }), try(var.remote_objects.public_ip_prefixes, {}))
  combined_objects_recovery_vaults                                = merge(tomap({ (local.client_config.landingzone_key) = module.recovery_vaults }), try(var.remote_objects.recovery_vaults, {}))
  combined_objects_redis_caches                                   = merge(tomap({ (local.client_config.landingzone_key) = module.redis_caches }), try(var.remote_objects.redis_caches, {}))
  combined_objects_relay_namespace                                = merge(tomap({ (local.client_config.landingzone_key) = module.relay_namespace }), try(var.remote_objects.relay_namespace, {}))
  combined_objects_relay_hybrid_connection                        = merge(tomap({ (local.client_config.landingzone_key) = module.relay_hybrid_connection }), try(var.remote_objects.relay_hybrid_connection, {}))
  combined_objects_resource_groups                                = merge(tomap({ (local.client_config.landingzone_key) = local.resource_groups }), try(var.remote_objects.resource_groups, {}))
  combined_objects_sentinel_watchlists                            = merge(tomap({ (local.client_config.landingzone_key) = module.sentinel_watchlists }), try(var.remote_objects.sentinel_watchlists, {}))
  combined_objects_servicebus_namespaces                          = merge(tomap({ (local.client_config.landingzone_key) = module.servicebus_namespaces }), try(var.remote_objects.servicebus_namespaces, {}))
  combined_objects_servicebus_topics                              = merge(tomap({ (local.client_config.landingzone_key) = module.servicebus_topics }), try(var.remote_objects.servicebus_topics, {}))
  combined_objects_servicebus_queues                              = merge(tomap({ (local.client_config.landingzone_key) = module.servicebus_queues }), try(var.remote_objects.servicebus_queues, {}))
  combined_objects_signalr_services                               = merge(tomap({ (local.client_config.landingzone_key) = module.signalr_services }), try(var.remote_objects.signalr_services, {}))
  combined_objects_storage_accounts                               = merge(tomap({ (local.client_config.landingzone_key) = module.storage_accounts }), try(var.remote_objects.storage_accounts, {}))
  combined_objects_storage_containers                             = merge(tomap({ (local.client_config.landingzone_key) = module.storage_containers }), try(var.remote_objects.storage_containers, {}))
  combined_objects_storage_account_queues                         = merge(tomap({ (local.client_config.landingzone_key) = module.storage_account_queues }), try(var.remote_objects.storage_account_queues, {}))
  combined_objects_synapse_workspaces                             = merge(tomap({ (local.client_config.landingzone_key) = module.synapse_workspaces }), try(var.remote_objects.synapse_workspaces, {}))
  combined_objects_virtual_hub_connections                        = merge(tomap({ (local.client_config.landingzone_key) = azurerm_virtual_hub_connection.vhub_connection }), try(var.remote_objects.vhub_peerings, {}), try(var.remote_objects.virtual_hub_connections, {}))
  combined_objects_virtual_hub_route_tables                       = merge(tomap({ (local.client_config.landingzone_key) = azurerm_virtual_hub_route_table.route_table }), try(var.remote_objects.virtual_hub_route_tables, {}))
  combined_objects_virtual_hubs                                   = merge(tomap({ (local.client_config.landingzone_key) = module.virtual_hubs }), try(var.remote_objects.virtual_hubs, {}))
  combined_objects_virtual_machine_scale_sets                     = merge(tomap({ (local.client_config.landingzone_key) = module.virtual_machine_scale_sets }), try(var.remote_objects.virtual_machine_scale_sets, {}))
  combined_objects_virtual_machines                               = merge(tomap({ (local.client_config.landingzone_key) = module.virtual_machines }), try(var.remote_objects.virtual_machines, {}))
  combined_objects_virtual_subnets                                = merge(tomap({ (local.client_config.landingzone_key) = module.virtual_subnets }), try(var.remote_objects.virtual_subnets, {}))
  combined_objects_virtual_wans                                   = merge(tomap({ (local.client_config.landingzone_key) = module.virtual_wans }), try(var.remote_objects.virtual_wans, {}))
  combined_objects_vmware_clusters                                = merge(tomap({ (local.client_config.landingzone_key) = module.vmware_clusters }), try(var.remote_objects.vmware_clusters, {}))
  combined_objects_vmware_express_route_authorizations            = merge(tomap({ (local.client_config.landingzone_key) = module.vmware_express_route_authorizations }), try(var.remote_objects.vmware_express_route_authorizations, {}))
  combined_objects_vmware_private_clouds                          = merge(tomap({ (local.client_config.landingzone_key) = module.vmware_private_clouds }), try(var.remote_objects.vmware_private_clouds, {}))
  combined_objects_vpn_gateway_connections                        = merge(tomap({ (local.client_config.landingzone_key) = module.vpn_gateway_connections }), try(var.remote_objects.vpn_gateway_connections, {}))
  combined_objects_vpn_sites                                      = merge(tomap({ (local.client_config.landingzone_key) = module.vpn_sites }), try(var.remote_objects.vpn_sites, {}))
  combined_objects_wvd_application_groups                         = merge(tomap({ (local.client_config.landingzone_key) = module.wvd_application_groups }), try(var.remote_objects.wvd_application_groups, {}))
  combined_objects_wvd_applications                               = merge(tomap({ (local.client_config.landingzone_key) = module.wvd_applications }), try(var.remote_objects.wvd_applications, {}))
  combined_objects_wvd_host_pools                                 = merge(tomap({ (local.client_config.landingzone_key) = module.wvd_host_pools }), try(var.remote_objects.wvd_host_pools, {}))
  combined_objects_wvd_workspaces                                 = merge(tomap({ (local.client_config.landingzone_key) = module.wvd_workspaces }), try(var.remote_objects.wvd_workspaces, {}))

  combined_objects_subscriptions = merge(
    tomap(
      {
        (local.client_config.landingzone_key) = merge(
          try(module.subscriptions, {}),
          { ("logged_in_subscription") = { id = data.azurerm_subscription.primary.id } }
        )
      }
    ),
    try(var.remote_objects.subscriptions, {})
  )

}
 