# Cloud Adoption Framework for Azure - Terraform module examples

Getting started with examples, once you have cloned this repository locally

## Deploying examples with Terraform

Each module can be deployed outside of the rover using native Terraform.

You can instantiate this directly using the following syntax:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
  # insert the 7 required variables here
}
```

Please refer to the instructions within each example directory, whenever you have a /standalone subdirectory.


## Deploying examples with rover

To get started with the deployment within rover, follow the steps:

1. Log in the subscription with the rover

```bash
rover login
### you can alternatively specify the tenant space and subscription ID on command line arguments:
rover login --tenant <tenant_name>.onmicrosoft.com -s <subscription_id>
```

2. Deploy the basic launchpad

```bash
rover -lz /tf/caf/public/landingzones/caf_launchpad \
-launchpad \
-var-folder /tf/caf/public/landingzones/caf_launchpad/scenario/100 \
-a apply
```

3. Test your example

```bash
rover -lz /tf/caf/landingzones/caf_example \
-var-folder /tf/caf/examples/<path of the example> \
-a plan|apply
```

## Developing and testing module for landing zones

Use those instructions only if you want to test, and develop features for landing zones with this module. You will need to add landing zones locally:

1. Clone the Azure landing zones repo

```bash
git clone --branch <public_version_you_want_to_use> https://github.com/Azure/caf-terraform-landingzones.git /tf/caf/public
```

This will clone the logic of landing zones in your local repository without committing your landing zones changes (we have put for you a filter on /public for landing zones.)

2. Change the module path in your landing zone

By default the landing zone will source the module from the registry.

For each landing zone you want to edit, go to the ```landingzone.tf``` file:

```
module "networking" {
  source  = "aztfmod/caf/azurerm"
  version = "~> 0.4"
```

You can replace it with your local path, typically here:

```
module "networking" {
  source  = "../../.."
```

You should now be able to run landing zones as usual, except it will source the module locally, so you can test the features you introduced in the module.

## Using the examples

You can customize the examples execution by modifying the variables as follow:

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dynamic_keyvault_secrets"></a> [dynamic\_keyvault\_secrets](#module\_dynamic\_keyvault\_secrets) | aztfmod/caf/azurerm//modules/security/dynamic_keyvault_secrets | ~>5.3.2 |
| <a name="module_example"></a> [example](#module\_example) | ../.. | n/a |
| <a name="module_vm_extension_diagnostics"></a> [vm\_extension\_diagnostics](#module\_vm\_extension\_diagnostics) | ../../modules/compute/virtual_machine_extensions | n/a |
| <a name="module_vm_extension_microsoft_azure_domainjoin"></a> [vm\_extension\_microsoft\_azure\_domainjoin](#module\_vm\_extension\_microsoft\_azure\_domainjoin) | ../../modules/compute/virtual_machine_extensions | n/a |
| <a name="module_vm_extension_monitoring_agent"></a> [vm\_extension\_monitoring\_agent](#module\_vm\_extension\_monitoring\_agent) | ../../modules/compute/virtual_machine_extensions | n/a |
| <a name="module_vm_extension_session_host_dscextension"></a> [vm\_extension\_session\_host\_dscextension](#module\_vm\_extension\_session\_host\_dscextension) | ../../modules/compute/virtual_machine_extensions | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acrLoginServerEndpoint"></a> [acrLoginServerEndpoint](#input\_acrLoginServerEndpoint) | n/a | `string` | `".azurecr.io"` | no |
| <a name="input_activeDirectory"></a> [activeDirectory](#input\_activeDirectory) | n/a | `string` | `"https://login.microsoftonline.com"` | no |
| <a name="input_activeDirectoryDataLakeResourceId"></a> [activeDirectoryDataLakeResourceId](#input\_activeDirectoryDataLakeResourceId) | n/a | `string` | `"https://datalake.azure.net/"` | no |
| <a name="input_activeDirectoryGraphResourceId"></a> [activeDirectoryGraphResourceId](#input\_activeDirectoryGraphResourceId) | n/a | `string` | `"https://graph.windows.net/"` | no |
| <a name="input_activeDirectoryResourceId"></a> [activeDirectoryResourceId](#input\_activeDirectoryResourceId) | n/a | `string` | `"https://management.core.windows.net/"` | no |
| <a name="input_aks_clusters"></a> [aks\_clusters](#input\_aks\_clusters) | n/a | `map` | `{}` | no |
| <a name="input_appInsightsResourceId"></a> [appInsightsResourceId](#input\_appInsightsResourceId) | n/a | `string` | `"https://api.applicationinsights.io"` | no |
| <a name="input_appInsightsTelemetryChannelResourceId"></a> [appInsightsTelemetryChannelResourceId](#input\_appInsightsTelemetryChannelResourceId) | n/a | `string` | `"https://dc.applicationinsights.azure.com/v2/track"` | no |
| <a name="input_app_service_environments"></a> [app\_service\_environments](#input\_app\_service\_environments) | n/a | `map` | `{}` | no |
| <a name="input_app_service_plans"></a> [app\_service\_plans](#input\_app\_service\_plans) | n/a | `map` | `{}` | no |
| <a name="input_app_services"></a> [app\_services](#input\_app\_services) | n/a | `map` | `{}` | no |
| <a name="input_application_gateway_applications"></a> [application\_gateway\_applications](#input\_application\_gateway\_applications) | n/a | `map` | `{}` | no |
| <a name="input_application_gateway_waf_policies"></a> [application\_gateway\_waf\_policies](#input\_application\_gateway\_waf\_policies) | n/a | `map` | `{}` | no |
| <a name="input_application_gateways"></a> [application\_gateways](#input\_application\_gateways) | n/a | `map` | `{}` | no |
| <a name="input_application_security_groups"></a> [application\_security\_groups](#input\_application\_security\_groups) | n/a | `map` | `{}` | no |
| <a name="input_attestationEndpoint"></a> [attestationEndpoint](#input\_attestationEndpoint) | n/a | `string` | `".attest.azure.net"` | no |
| <a name="input_attestationResourceId"></a> [attestationResourceId](#input\_attestationResourceId) | n/a | `string` | `"https://attest.azure.net"` | no |
| <a name="input_automations"></a> [automations](#input\_automations) | n/a | `map` | `{}` | no |
| <a name="input_availability_sets"></a> [availability\_sets](#input\_availability\_sets) | n/a | `map` | `{}` | no |
| <a name="input_azmirrorStorageAccountResourceId"></a> [azmirrorStorageAccountResourceId](#input\_azmirrorStorageAccountResourceId) | n/a | `string` | `"null"` | no |
| <a name="input_azureDatalakeAnalyticsCatalogAndJobEndpoint"></a> [azureDatalakeAnalyticsCatalogAndJobEndpoint](#input\_azureDatalakeAnalyticsCatalogAndJobEndpoint) | n/a | `string` | `"azuredatalakeanalytics.net"` | no |
| <a name="input_azureDatalakeStoreFileSystemEndpoint"></a> [azureDatalakeStoreFileSystemEndpoint](#input\_azureDatalakeStoreFileSystemEndpoint) | n/a | `string` | `"azuredatalakestore.net"` | no |
| <a name="input_azure_container_registries"></a> [azure\_container\_registries](#input\_azure\_container\_registries) | n/a | `map` | `{}` | no |
| <a name="input_azuread_api_permissions"></a> [azuread\_api\_permissions](#input\_azuread\_api\_permissions) | n/a | `map` | `{}` | no |
| <a name="input_azuread_applications"></a> [azuread\_applications](#input\_azuread\_applications) | n/a | `map` | `{}` | no |
| <a name="input_azuread_apps"></a> [azuread\_apps](#input\_azuread\_apps) | n/a | `map(any)` | `{}` | no |
| <a name="input_azuread_credential_policies"></a> [azuread\_credential\_policies](#input\_azuread\_credential\_policies) | n/a | `map` | `{}` | no |
| <a name="input_azuread_credentials"></a> [azuread\_credentials](#input\_azuread\_credentials) | n/a | `map` | `{}` | no |
| <a name="input_azuread_groups"></a> [azuread\_groups](#input\_azuread\_groups) | n/a | `map` | `{}` | no |
| <a name="input_azuread_roles"></a> [azuread\_roles](#input\_azuread\_roles) | n/a | `map` | `{}` | no |
| <a name="input_azuread_service_principal_passwords"></a> [azuread\_service\_principal\_passwords](#input\_azuread\_service\_principal\_passwords) | n/a | `map` | `{}` | no |
| <a name="input_azuread_service_principals"></a> [azuread\_service\_principals](#input\_azuread\_service\_principals) | n/a | `map` | `{}` | no |
| <a name="input_azuread_users"></a> [azuread\_users](#input\_azuread\_users) | n/a | `map(any)` | `{}` | no |
| <a name="input_azurerm_application_insights"></a> [azurerm\_application\_insights](#input\_azurerm\_application\_insights) | n/a | `map` | `{}` | no |
| <a name="input_azurerm_firewall_application_rule_collection_definition"></a> [azurerm\_firewall\_application\_rule\_collection\_definition](#input\_azurerm\_firewall\_application\_rule\_collection\_definition) | n/a | `map` | `{}` | no |
| <a name="input_azurerm_firewall_nat_rule_collection_definition"></a> [azurerm\_firewall\_nat\_rule\_collection\_definition](#input\_azurerm\_firewall\_nat\_rule\_collection\_definition) | n/a | `map` | `{}` | no |
| <a name="input_azurerm_firewall_network_rule_collection_definition"></a> [azurerm\_firewall\_network\_rule\_collection\_definition](#input\_azurerm\_firewall\_network\_rule\_collection\_definition) | n/a | `map` | `{}` | no |
| <a name="input_azurerm_firewall_policies"></a> [azurerm\_firewall\_policies](#input\_azurerm\_firewall\_policies) | n/a | `map` | `{}` | no |
| <a name="input_azurerm_firewall_policy_rule_collection_groups"></a> [azurerm\_firewall\_policy\_rule\_collection\_groups](#input\_azurerm\_firewall\_policy\_rule\_collection\_groups) | n/a | `map` | `{}` | no |
| <a name="input_azurerm_firewalls"></a> [azurerm\_firewalls](#input\_azurerm\_firewalls) | n/a | `map` | `{}` | no |
| <a name="input_azurerm_redis_caches"></a> [azurerm\_redis\_caches](#input\_azurerm\_redis\_caches) | n/a | `map` | `{}` | no |
| <a name="input_azurerm_routes"></a> [azurerm\_routes](#input\_azurerm\_routes) | n/a | `map` | `{}` | no |
| <a name="input_bastion_hosts"></a> [bastion\_hosts](#input\_bastion\_hosts) | n/a | `map` | `{}` | no |
| <a name="input_batchResourceId"></a> [batchResourceId](#input\_batchResourceId) | n/a | `string` | `"https://batch.core.windows.net/"` | no |
| <a name="input_cloud"></a> [cloud](#input\_cloud) | n/a | `map` | `{}` | no |
| <a name="input_container_groups"></a> [container\_groups](#input\_container\_groups) | n/a | `map` | `{}` | no |
| <a name="input_cosmos_db"></a> [cosmos\_db](#input\_cosmos\_db) | n/a | `map` | `{}` | no |
| <a name="input_cosmos_dbs"></a> [cosmos\_dbs](#input\_cosmos\_dbs) | n/a | `map` | `{}` | no |
| <a name="input_custom_role_definitions"></a> [custom\_role\_definitions](#input\_custom\_role\_definitions) | n/a | `map` | `{}` | no |
| <a name="input_databricks_workspaces"></a> [databricks\_workspaces](#input\_databricks\_workspaces) | n/a | `map` | `{}` | no |
| <a name="input_dedicated_host_groups"></a> [dedicated\_host\_groups](#input\_dedicated\_host\_groups) | n/a | `map` | `{}` | no |
| <a name="input_dedicated_hosts"></a> [dedicated\_hosts](#input\_dedicated\_hosts) | n/a | `map` | `{}` | no |
| <a name="input_diagnostic_event_hub_namespaces"></a> [diagnostic\_event\_hub\_namespaces](#input\_diagnostic\_event\_hub\_namespaces) | n/a | `map` | `{}` | no |
| <a name="input_diagnostic_log_analytics"></a> [diagnostic\_log\_analytics](#input\_diagnostic\_log\_analytics) | n/a | `map` | `{}` | no |
| <a name="input_diagnostic_storage_accounts"></a> [diagnostic\_storage\_accounts](#input\_diagnostic\_storage\_accounts) | n/a | `map` | `{}` | no |
| <a name="input_diagnostics_definition"></a> [diagnostics\_definition](#input\_diagnostics\_definition) | n/a | `map` | `{}` | no |
| <a name="input_diagnostics_destinations"></a> [diagnostics\_destinations](#input\_diagnostics\_destinations) | n/a | `map` | `{}` | no |
| <a name="input_disk_encryption_sets"></a> [disk\_encryption\_sets](#input\_disk\_encryption\_sets) | n/a | `map` | `{}` | no |
| <a name="input_dns_zone_records"></a> [dns\_zone\_records](#input\_dns\_zone\_records) | n/a | `map` | `{}` | no |
| <a name="input_dns_zones"></a> [dns\_zones](#input\_dns\_zones) | n/a | `map` | `{}` | no |
| <a name="input_domain_name_registrations"></a> [domain\_name\_registrations](#input\_domain\_name\_registrations) | n/a | `map` | `{}` | no |
| <a name="input_dynamic_keyvault_secrets"></a> [dynamic\_keyvault\_secrets](#input\_dynamic\_keyvault\_secrets) | n/a | `map` | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"sandpit"` | no |
| <a name="input_event_hub_auth_rules"></a> [event\_hub\_auth\_rules](#input\_event\_hub\_auth\_rules) | n/a | `map` | `{}` | no |
| <a name="input_event_hub_consumer_groups"></a> [event\_hub\_consumer\_groups](#input\_event\_hub\_consumer\_groups) | n/a | `map` | `{}` | no |
| <a name="input_event_hub_namespace_auth_rules"></a> [event\_hub\_namespace\_auth\_rules](#input\_event\_hub\_namespace\_auth\_rules) | n/a | `map` | `{}` | no |
| <a name="input_event_hub_namespaces"></a> [event\_hub\_namespaces](#input\_event\_hub\_namespaces) | n/a | `map` | `{}` | no |
| <a name="input_event_hubs"></a> [event\_hubs](#input\_event\_hubs) | n/a | `map` | `{}` | no |
| <a name="input_express_route_circuit_authorizations"></a> [express\_route\_circuit\_authorizations](#input\_express\_route\_circuit\_authorizations) | n/a | `map` | `{}` | no |
| <a name="input_express_route_circuits"></a> [express\_route\_circuits](#input\_express\_route\_circuits) | n/a | `map` | `{}` | no |
| <a name="input_front_door_waf_policies"></a> [front\_door\_waf\_policies](#input\_front\_door\_waf\_policies) | n/a | `map` | `{}` | no |
| <a name="input_front_doors"></a> [front\_doors](#input\_front\_doors) | n/a | `map` | `{}` | no |
| <a name="input_gallery"></a> [gallery](#input\_gallery) | n/a | `string` | `"https://gallery.azure.com/"` | no |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | n/a | `map` | <pre>{<br>  "default_region": "region1",<br>  "regions": {<br>    "region1": "southeastasia",<br>    "region2": "eastasia"<br>  }<br>}</pre> | no |
| <a name="input_image_definitions"></a> [image\_definitions](#input\_image\_definitions) | n/a | `map` | `{}` | no |
| <a name="input_ip_groups"></a> [ip\_groups](#input\_ip\_groups) | n/a | `map` | `{}` | no |
| <a name="input_keyvaultDns"></a> [keyvaultDns](#input\_keyvaultDns) | n/a | `string` | `".vault.azure.net"` | no |
| <a name="input_keyvault_access_policies"></a> [keyvault\_access\_policies](#input\_keyvault\_access\_policies) | n/a | `map` | `{}` | no |
| <a name="input_keyvault_access_policies_azuread_apps"></a> [keyvault\_access\_policies\_azuread\_apps](#input\_keyvault\_access\_policies\_azuread\_apps) | n/a | `map` | `{}` | no |
| <a name="input_keyvault_certificate_issuers"></a> [keyvault\_certificate\_issuers](#input\_keyvault\_certificate\_issuers) | n/a | `map` | `{}` | no |
| <a name="input_keyvault_certificate_requests"></a> [keyvault\_certificate\_requests](#input\_keyvault\_certificate\_requests) | n/a | `map` | `{}` | no |
| <a name="input_keyvault_certificates"></a> [keyvault\_certificates](#input\_keyvault\_certificates) | n/a | `map` | `{}` | no |
| <a name="input_keyvault_keys"></a> [keyvault\_keys](#input\_keyvault\_keys) | n/a | `map` | `{}` | no |
| <a name="input_keyvaults"></a> [keyvaults](#input\_keyvaults) | n/a | `map` | `{}` | no |
| <a name="input_landingzone"></a> [landingzone](#input\_landingzone) | n/a | `map` | <pre>{<br>  "backend_type": "azurerm",<br>  "global_settings_key": "launchpad",<br>  "key": "examples",<br>  "level": "level0"<br>}</pre> | no |
| <a name="input_lighthouse_definitions"></a> [lighthouse\_definitions](#input\_lighthouse\_definitions) | n/a | `map` | `{}` | no |
| <a name="input_load_balancers"></a> [load\_balancers](#input\_load\_balancers) | n/a | `map` | `{}` | no |
| <a name="input_local_network_gateways"></a> [local\_network\_gateways](#input\_local\_network\_gateways) | n/a | `map` | `{}` | no |
| <a name="input_logAnalyticsResourceId"></a> [logAnalyticsResourceId](#input\_logAnalyticsResourceId) | n/a | `string` | `"https://api.loganalytics.io"` | no |
| <a name="input_log_analytics"></a> [log\_analytics](#input\_log\_analytics) | n/a | `map` | `{}` | no |
| <a name="input_logged_aad_app_objectId"></a> [logged\_aad\_app\_objectId](#input\_logged\_aad\_app\_objectId) | n/a | `any` | `null` | no |
| <a name="input_logged_user_objectId"></a> [logged\_user\_objectId](#input\_logged\_user\_objectId) | n/a | `any` | `null` | no |
| <a name="input_machine_learning_workspaces"></a> [machine\_learning\_workspaces](#input\_machine\_learning\_workspaces) | n/a | `map` | `{}` | no |
| <a name="input_managed_identities"></a> [managed\_identities](#input\_managed\_identities) | n/a | `map` | `{}` | no |
| <a name="input_management"></a> [management](#input\_management) | n/a | `string` | `"https://management.core.windows.net/"` | no |
| <a name="input_mariadbServerEndpoint"></a> [mariadbServerEndpoint](#input\_mariadbServerEndpoint) | n/a | `string` | `".mariadb.database.azure.com"` | no |
| <a name="input_mariadb_databases"></a> [mariadb\_databases](#input\_mariadb\_databases) | n/a | `map` | `{}` | no |
| <a name="input_mariadb_servers"></a> [mariadb\_servers](#input\_mariadb\_servers) | n/a | `map` | `{}` | no |
| <a name="input_mediaResourceId"></a> [mediaResourceId](#input\_mediaResourceId) | n/a | `string` | `"https://rest.media.azure.net"` | no |
| <a name="input_mhsmDns"></a> [mhsmDns](#input\_mhsmDns) | n/a | `string` | `".managedhsm.azure.net"` | no |
| <a name="input_microsoftGraphResourceId"></a> [microsoftGraphResourceId](#input\_microsoftGraphResourceId) | n/a | `string` | `"https://graph.microsoft.com/"` | no |
| <a name="input_monitoring"></a> [monitoring](#input\_monitoring) | n/a | `map` | `{}` | no |
| <a name="input_mssql_databases"></a> [mssql\_databases](#input\_mssql\_databases) | n/a | `map` | `{}` | no |
| <a name="input_mssql_elastic_pools"></a> [mssql\_elastic\_pools](#input\_mssql\_elastic\_pools) | n/a | `map` | `{}` | no |
| <a name="input_mssql_failover_groups"></a> [mssql\_failover\_groups](#input\_mssql\_failover\_groups) | n/a | `map` | `{}` | no |
| <a name="input_mssql_managed_databases"></a> [mssql\_managed\_databases](#input\_mssql\_managed\_databases) | n/a | `map` | `{}` | no |
| <a name="input_mssql_managed_databases_backup_ltr"></a> [mssql\_managed\_databases\_backup\_ltr](#input\_mssql\_managed\_databases\_backup\_ltr) | n/a | `map` | `{}` | no |
| <a name="input_mssql_managed_databases_restore"></a> [mssql\_managed\_databases\_restore](#input\_mssql\_managed\_databases\_restore) | n/a | `map` | `{}` | no |
| <a name="input_mssql_managed_instances"></a> [mssql\_managed\_instances](#input\_mssql\_managed\_instances) | n/a | `map` | `{}` | no |
| <a name="input_mssql_managed_instances_secondary"></a> [mssql\_managed\_instances\_secondary](#input\_mssql\_managed\_instances\_secondary) | n/a | `map` | `{}` | no |
| <a name="input_mssql_mi_administrators"></a> [mssql\_mi\_administrators](#input\_mssql\_mi\_administrators) | n/a | `map` | `{}` | no |
| <a name="input_mssql_mi_failover_groups"></a> [mssql\_mi\_failover\_groups](#input\_mssql\_mi\_failover\_groups) | n/a | `map` | `{}` | no |
| <a name="input_mssql_mi_secondary_tdes"></a> [mssql\_mi\_secondary\_tdes](#input\_mssql\_mi\_secondary\_tdes) | n/a | `map` | `{}` | no |
| <a name="input_mssql_mi_tdes"></a> [mssql\_mi\_tdes](#input\_mssql\_mi\_tdes) | n/a | `map` | `{}` | no |
| <a name="input_mssql_servers"></a> [mssql\_servers](#input\_mssql\_servers) | n/a | `map` | `{}` | no |
| <a name="input_mysqlServerEndpoint"></a> [mysqlServerEndpoint](#input\_mysqlServerEndpoint) | n/a | `string` | `".mysql.database.azure.com"` | no |
| <a name="input_mysql_servers"></a> [mysql\_servers](#input\_mysql\_servers) | n/a | `map` | `{}` | no |
| <a name="input_netapp_accounts"></a> [netapp\_accounts](#input\_netapp\_accounts) | n/a | `map` | `{}` | no |
| <a name="input_network_security_group_definition"></a> [network\_security\_group\_definition](#input\_network\_security\_group\_definition) | n/a | `map` | `{}` | no |
| <a name="input_network_watchers"></a> [network\_watchers](#input\_network\_watchers) | n/a | `map` | `{}` | no |
| <a name="input_ossrdbmsResourceId"></a> [ossrdbmsResourceId](#input\_ossrdbmsResourceId) | n/a | `string` | `"https://ossrdbms-aad.database.windows.net"` | no |
| <a name="input_packer_managed_identity"></a> [packer\_managed\_identity](#input\_packer\_managed\_identity) | n/a | `map` | `{}` | no |
| <a name="input_packer_service_principal"></a> [packer\_service\_principal](#input\_packer\_service\_principal) | n/a | `map` | `{}` | no |
| <a name="input_portal"></a> [portal](#input\_portal) | n/a | `string` | `"https://portal.azure.com"` | no |
| <a name="input_postgresqlServerEndpoint"></a> [postgresqlServerEndpoint](#input\_postgresqlServerEndpoint) | n/a | `string` | `".postgres.database.azure.com"` | no |
| <a name="input_postgresql_servers"></a> [postgresql\_servers](#input\_postgresql\_servers) | n/a | `map` | `{}` | no |
| <a name="input_private_dns"></a> [private\_dns](#input\_private\_dns) | n/a | `map` | `{}` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | n/a | `map` | `{}` | no |
| <a name="input_provider_azurerm_features_keyvault"></a> [provider\_azurerm\_features\_keyvault](#input\_provider\_azurerm\_features\_keyvault) | n/a | `map` | <pre>{<br>  "purge_soft_delete_on_destroy": true<br>}</pre> | no |
| <a name="input_proximity_placement_groups"></a> [proximity\_placement\_groups](#input\_proximity\_placement\_groups) | n/a | `map` | `{}` | no |
| <a name="input_public_ip_addresses"></a> [public\_ip\_addresses](#input\_public\_ip\_addresses) | n/a | `map` | `{}` | no |
| <a name="input_recovery_vaults"></a> [recovery\_vaults](#input\_recovery\_vaults) | n/a | `map` | `{}` | no |
| <a name="input_resourceManager"></a> [resourceManager](#input\_resourceManager) | n/a | `string` | `"https://management.azure.com/"` | no |
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | n/a | `map` | `{}` | no |
| <a name="input_role_mapping"></a> [role\_mapping](#input\_role\_mapping) | n/a | `map` | `{}` | no |
| <a name="input_route_tables"></a> [route\_tables](#input\_route\_tables) | n/a | `map` | `{}` | no |
| <a name="input_rover_version"></a> [rover\_version](#input\_rover\_version) | n/a | `any` | `null` | no |
| <a name="input_shared_image_galleries"></a> [shared\_image\_galleries](#input\_shared\_image\_galleries) | n/a | `map` | `{}` | no |
| <a name="input_sqlManagement"></a> [sqlManagement](#input\_sqlManagement) | n/a | `string` | `"https://management.core.windows.net:8443/"` | no |
| <a name="input_sqlServerHostname"></a> [sqlServerHostname](#input\_sqlServerHostname) | n/a | `string` | `".database.windows.net"` | no |
| <a name="input_storageEndpoint"></a> [storageEndpoint](#input\_storageEndpoint) | n/a | `string` | `"core.windows.net"` | no |
| <a name="input_storageSyncEndpoint"></a> [storageSyncEndpoint](#input\_storageSyncEndpoint) | n/a | `string` | `"afs.azure.net"` | no |
| <a name="input_storage_accounts"></a> [storage\_accounts](#input\_storage\_accounts) | n/a | `map` | `{}` | no |
| <a name="input_subscription_billing_role_assignments"></a> [subscription\_billing\_role\_assignments](#input\_subscription\_billing\_role\_assignments) | n/a | `map` | `{}` | no |
| <a name="input_synapseAnalyticsEndpoint"></a> [synapseAnalyticsEndpoint](#input\_synapseAnalyticsEndpoint) | n/a | `string` | `".dev.azuresynapse.net"` | no |
| <a name="input_synapseAnalyticsResourceId"></a> [synapseAnalyticsResourceId](#input\_synapseAnalyticsResourceId) | n/a | `string` | `"https://dev.azuresynapse.net"` | no |
| <a name="input_synapse_workspaces"></a> [synapse\_workspaces](#input\_synapse\_workspaces) | n/a | `map` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | `null` | no |
| <a name="input_var_folder_path"></a> [var\_folder\_path](#input\_var\_folder\_path) | n/a | `map` | `{}` | no |
| <a name="input_vhub_peerings"></a> [vhub\_peerings](#input\_vhub\_peerings) | Use virtual\_hub\_connections instead of vhub\_peerings. It will be removed in version 6.0 | `map` | `{}` | no |
| <a name="input_virtual_hub_connections"></a> [virtual\_hub\_connections](#input\_virtual\_hub\_connections) | n/a | `map` | `{}` | no |
| <a name="input_virtual_hub_er_gateway_connections"></a> [virtual\_hub\_er\_gateway\_connections](#input\_virtual\_hub\_er\_gateway\_connections) | n/a | `map` | `{}` | no |
| <a name="input_virtual_hub_route_tables"></a> [virtual\_hub\_route\_tables](#input\_virtual\_hub\_route\_tables) | n/a | `map` | `{}` | no |
| <a name="input_virtual_hubs"></a> [virtual\_hubs](#input\_virtual\_hubs) | n/a | `map` | `{}` | no |
| <a name="input_virtual_machine_scale_sets"></a> [virtual\_machine\_scale\_sets](#input\_virtual\_machine\_scale\_sets) | n/a | `map` | `{}` | no |
| <a name="input_virtual_machines"></a> [virtual\_machines](#input\_virtual\_machines) | n/a | `map` | `{}` | no |
| <a name="input_virtual_network_gateway_connections"></a> [virtual\_network\_gateway\_connections](#input\_virtual\_network\_gateway\_connections) | n/a | `map` | `{}` | no |
| <a name="input_virtual_network_gateways"></a> [virtual\_network\_gateways](#input\_virtual\_network\_gateways) | n/a | `map` | `{}` | no |
| <a name="input_virtual_wans"></a> [virtual\_wans](#input\_virtual\_wans) | n/a | `map` | `{}` | no |
| <a name="input_vmImageAliasDoc"></a> [vmImageAliasDoc](#input\_vmImageAliasDoc) | n/a | `string` | `"https://raw.githubusercontent.com/Azure/azure-rest-api-specs/master/arm-compute/quickstart-templates/aliases.json"` | no |
| <a name="input_vnet_peerings"></a> [vnet\_peerings](#input\_vnet\_peerings) | n/a | `map` | `{}` | no |
| <a name="input_vnets"></a> [vnets](#input\_vnets) | n/a | `map` | `{}` | no |
| <a name="input_vpn_gateway_connections"></a> [vpn\_gateway\_connections](#input\_vpn\_gateway\_connections) | n/a | `map` | `{}` | no |
| <a name="input_vpn_sites"></a> [vpn\_sites](#input\_vpn\_sites) | n/a | `map` | `{}` | no |
| <a name="input_wvd_application_groups"></a> [wvd\_application\_groups](#input\_wvd\_application\_groups) | n/a | `map` | `{}` | no |
| <a name="input_wvd_applications"></a> [wvd\_applications](#input\_wvd\_applications) | n/a | `map` | `{}` | no |
| <a name="input_wvd_host_pools"></a> [wvd\_host\_pools](#input\_wvd\_host\_pools) | n/a | `map` | `{}` | no |
| <a name="input_wvd_workspaces"></a> [wvd\_workspaces](#input\_wvd\_workspaces) | n/a | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_objects"></a> [objects](#output\_objects) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
