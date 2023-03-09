output "id" {
  value = azapi_resource.container_app_env.id
}

output "default_domain" {
  value = jsondecode(azapi_resource.container_app_env.output).properties.defaultDomain
}

output "static_ip" {
  value = jsondecode(azapi_resource.container_app_env.output).properties.staticIp
}

output "vnet_configuration" {
  value = jsondecode(azapi_resource.container_app_env.output).properties.vnetConfiguration
}
# jsondecode(data.azapi_resource.container_apps["catalog_search"].output)
