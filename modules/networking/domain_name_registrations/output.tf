output "dns_domain_registration_name" {
  description = "DNS domain name purchased"
  value       = local.dns_domain_name
}

output "dns_domain_registration_id" {
  description = "DNS domain name resource ID"
  value       = jsondecode(azurerm_resource_group_template_deployment.domain.output_content).id.value
}