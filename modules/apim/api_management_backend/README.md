module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# api_management_backend

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the API Management backend. Changing this forces a new resource to be created.||True|
|api_management|The `api_management` block as defined below.|Block|True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|protocol| The protocol used by the backend host. Possible values are `http` or `soap`.||True|
|url| The URL of the backend host.||True|
|credentials| A `credentials` block as documented below.| Block |False|
|description| The description of the backend.||False|
|proxy| A `proxy` block as documented below.| Block |False|
|resource_id| The management URI of the backend host in an external system. This URI can be the ARM Resource ID of Logic Apps, Function Apps or API Apps, or the management endpoint of a Service Fabric cluster.||False|
|service_fabric_cluster| A `service_fabric_cluster` block as documented below.| Block |False|
|title| The title of the backend.||False|
|tls| A `tls` block as documented below.| Block |False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|api_management| key | Key for  api_management||| Required if  |
|api_management| lz_key |Landing Zone Key in wich the api_management is located|||True|
|api_management| name | The name of the api_management |||True|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|credentials|authorization| An `authorization` block as defined below.|||False|
|authorization|parameter| The authentication Parameter value.|||False|
|authorization|scheme| The authentication Scheme name.|||False|
|credentials|certificate| A list of client certificate thumbprints to present to the backend host. The certificates must exist within the API Management Service.|||False|
|credentials|header| A mapping of header parameters to pass to the backend host. The keys are the header names and the values are a comma separated string of header values. This is converted to a list before being passed to the API.|||False|
|credentials|query| A mapping of query parameters to pass to the backend host. The keys are the query names and the values are a comma separated string of query values. This is converted to a list before being passed to the API.|||False|
|proxy|password| The password to connect to the proxy server.|||False|
|proxy|url| The URL of the proxy server.|||False|
|proxy|username| The username to connect to the proxy server.|||False|
|service_fabric_cluster|client_certificate_thumbprint| The client certificate thumbprint for the management endpoint.|||False|
|service_fabric_cluster|client_certificate_id| The client certificate resource id for the management endpoint.|||False|
|service_fabric_cluster|management_endpoints| A list of cluster management endpoints.|||True|
|service_fabric_cluster|max_partition_resolution_retries| The maximum number of retries when attempting resolve the partition.|||True|
|service_fabric_cluster|server_certificate_thumbprints| A list of thumbprints of the server certificates of the Service Fabric cluster.|||False|
|service_fabric_cluster|server_x509_name| One or more `server_x509_name` blocks as documented below.|||False|
|server_x509_name|issuer_certificate_thumbprint| The thumbprint for the issuer of the certificate.|||True|
|server_x509_name|name| The common name of the certificate.|||True|
|tls|validate_certificate_chain| Flag indicating whether SSL certificate chain validation should be done when using self-signed certificates for the backend host.|||False|
|tls|validate_certificate_name| Flag indicating whether SSL certificate name validation should be done when using self-signed certificates for the backend host.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the API Management API.|||
