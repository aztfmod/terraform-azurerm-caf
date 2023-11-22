output "id" {
  value       = azurerm_elastic_cloud_elasticsearch.ece.id
  description = "The ID of the Elasticsearch."
}

output "elastic_cloud_deployment_id" {
  value       = azurerm_elastic_cloud_elasticsearch.ece.elastic_cloud_deployment_id
  description = "The ID of the Deployment within Elastic Cloud."
}

output "elastic_cloud_sso_default_url" {
  value       = azurerm_elastic_cloud_elasticsearch.ece.elastic_cloud_sso_default_url 
  description = "The Default URL used for Single Sign On (SSO) to Elastic Cloud."
}

output "elastic_cloud_user_id" {
  value       = azurerm_elastic_cloud_elasticsearch.ece.elastic_cloud_user_id 
  description = "The ID of the User Account within Elastic Cloud."
}

output "elasticsearch_service_url" {
  value       = azurerm_elastic_cloud_elasticsearch.ece.elasticsearch_service_url 
  description = "The URL to the Elasticsearch Service associated with this Elasticsearch."
}

output "kibana_service_url" {
  value       = azurerm_elastic_cloud_elasticsearch.ece.kibana_service_url 
  description = "The URL to the Kibana Dashboard associated with this Elasticsearch."
}

output "kibana_sso_uri" {
  value       = azurerm_elastic_cloud_elasticsearch.ece.kibana_sso_uri 
  description = "The URI used for SSO to the Kibana Dashboard associated with this Elasticsearch."
}