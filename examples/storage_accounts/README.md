module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# storage_account

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the storage account. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|account_kind| Defines the Kind of account. Valid options are `BlobStorage`, `BlockBlobStorage`, `FileStorage`, `Storage` and `StorageV2`. Changing this forces a new resource to be created. Defaults to `StorageV2`.||False|
|account_tier| Defines the Tier to use for this storage account. Valid options are `Standard` and `Premium`. For `BlockBlobStorage` and `FileStorage` accounts only `Premium` is valid. Changing this forces a new resource to be created.||True|
|account_replication_type| Defines the type of replication to use for this storage account. Valid options are `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS` and `RAGZRS`. Changing this forces a new resource to be created when types `LRS`, `GRS` and `RAGRS` are changed to `ZRS`, `GZRS` or `RAGZRS` and vice versa.||True|
|access_tier| Defines the access tier for `BlobStorage`, `FileStorage` and `StorageV2` accounts. Valid options are `Hot` and `Cool`, defaults to `Hot`.||False|
|enable_https_traffic_only| Boolean flag which forces HTTPS if enabled, see [here](https://docs.microsoft.com/en-us/azure/storage/storage-require-secure-transfer/)||False|
|min_tls_version| The minimum supported TLS version for the storage account. Possible values are `TLS1_0`, `TLS1_1`, and `TLS1_2`. Defaults to `TLS1_0` for new storage accounts.||False|
|allow_blob_public_access|Allow or disallow public access to all blobs or containers in the storage account. Defaults to `false`.||False|
|shared_access_key_enabled|Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is `true`.||False|
|is_hns_enabled| Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 ([see here for more information](https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-quickstart-create-account/)). Changing this forces a new resource to be created.||False|
|account_kind| Defines the Kind of account. Valid options are `BlobStorage`, `BlockBlobStorage`, `FileStorage`, `Storage` and `StorageV2`. Changing this forces a new resource to be created. Defaults to `StorageV2`.||False|
|nfsv3_enabled| Is NFSv3 protocol enabled? Changing this forces a new resource to be created. Defaults to `false`.||False|
|custom_domain| A `custom_domain` block as documented below.| Block |False|
|identity| An `identity` block as defined below.| Block |False|
|blob_properties| A `blob_properties` block as defined below.| Block |False|
|queue_properties| A `queue_properties` block as defined below.| Block |False|
|queue_properties| A `queue_properties` block as defined below.| Block |False|
|static_website| A `static_website` block as defined below.| Block |False|
|static_website| A `static_website` block as defined below.| Block |False|
|network_rules| A `network_rules` block as documented below.| Block |False|
|large_file_share_enabled| Is Large File Share Enabled?||False|
|azure_files_authentication| A `azure_files_authentication` block as defined below.| Block |False|
|routing| A `routing` block as defined below.| Block |False|
|queue_encryption_key_type| The encryption type of the queue service. Possible values are `Service` and `Account`. Changing this forces a new resource to be created. Default value is `Service`. ||False|
|table_encryption_key_type| The encryption type of the table service. Possible values are `Service` and `Account`. Changing this forces a new resource to be created. Default value is `Service`. ||False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|custom_domain|name| The Custom Domain Name to use for the Storage Account, which will be validated by Azure.|||True|
|custom_domain|use_subdomain| Should the Custom Domain Name be validated by using indirect CNAME validation?|||False|
|identity|type| Specifies the identity type of the Storage Account. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned,UserAssigned` (to enable both).|||True|
|identity|identity_ids| A list of IDs for User Assigned Managed Identity resources to be assigned.|||False|
|blob_properties|cors_rule| A `cors_rule` block as defined below.|||False|
|cors_rule|allowed_headers| A list of headers that are allowed to be a part of the cross-origin request.|||True|
|cors_rule|allowed_methods| A list of http methods that are allowed to be executed by the origin. Valid options are|||True|
|cors_rule|allowed_origins| A list of origin domains that will be allowed by CORS.|||True|
|cors_rule|exposed_headers| A list of response headers that are exposed to CORS clients.|||True|
|cors_rule|max_age_in_seconds| The number of seconds the client should cache a preflight response.|||True|
|blob_properties|delete_retention_policy| A `delete_retention_policy` block as defined below.|||False|
|delete_retention_policy|days| Specifies the number of days that the blob should be retained, between `1` and `365` days. Defaults to `7`.|||False|
|blob_properties|versioning_enabled| Is versioning enabled? Default to `false`.|||False|
|blob_properties|change_feed_enabled| Is the blob service properties for change feed events enabled? Default to `false`.|||False|
|blob_properties|default_service_version| The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version. Defaults to `2020-06-12`.|||False|
|blob_properties|last_access_time_enabled| Is the last access time based tracking enabled? Default to `false`.|||False|
|blob_properties|container_delete_retention_policy| A `container_delete_retention_policy` block as defined below.|||False|
|container_delete_retention_policy|days| Specifies the number of days that the container should be retained, between `1` and `365` days. Defaults to `7`.|||False|
|queue_properties|cors_rule| A `cors_rule` block as defined above.|||False|
|cors_rule|allowed_headers| A list of headers that are allowed to be a part of the cross-origin request.|||True|
|cors_rule|allowed_methods| A list of http methods that are allowed to be executed by the origin. Valid options are|||True|
|cors_rule|allowed_origins| A list of origin domains that will be allowed by CORS.|||True|
|cors_rule|exposed_headers| A list of response headers that are exposed to CORS clients.|||True|
|cors_rule|max_age_in_seconds| The number of seconds the client should cache a preflight response.|||True|
|queue_properties|logging| A `logging` block as defined below.|||False|
|logging|delete| Indicates whether all delete requests should be logged. Changing this forces a new resource.|||True|
|logging|read| Indicates whether all read requests should be logged. Changing this forces a new resource.|||True|
|logging|version| The version of storage analytics to configure. Changing this forces a new resource.|||True|
|logging|write| Indicates whether all write requests should be logged. Changing this forces a new resource.|||True|
|logging|retention_policy_days| Specifies the number of days that logs will be retained. Changing this forces a new resource.|||False|
|queue_properties|minute_metrics| A `minute_metrics` block as defined below.|||False|
|minute_metrics|enabled| Indicates whether minute metrics are enabled for the Queue service. Changing this forces a new resource.|||True|
|minute_metrics|version| The version of storage analytics to configure. Changing this forces a new resource.|||True|
|minute_metrics|include_apis| Indicates whether metrics should generate summary statistics for called API operations.|||False|
|minute_metrics|retention_policy_days| Specifies the number of days that logs will be retained. Changing this forces a new resource.|||False|
|queue_properties|hour_metrics| A `hour_metrics` block as defined below.|||False|
|hour_metrics|enabled| Indicates whether hour metrics are enabled for the Queue service. Changing this forces a new resource.|||True|
|hour_metrics|version| The version of storage analytics to configure. Changing this forces a new resource.|||True|
|hour_metrics|include_apis| Indicates whether metrics should generate summary statistics for called API operations.|||False|
|hour_metrics|retention_policy_days| Specifies the number of days that logs will be retained. Changing this forces a new resource.|||False|
|queue_properties|cors_rule| A `cors_rule` block as defined above.|||False|
|cors_rule|allowed_headers| A list of headers that are allowed to be a part of the cross-origin request.|||True|
|cors_rule|allowed_methods| A list of http methods that are allowed to be executed by the origin. Valid options are|||True|
|cors_rule|allowed_origins| A list of origin domains that will be allowed by CORS.|||True|
|cors_rule|exposed_headers| A list of response headers that are exposed to CORS clients.|||True|
|cors_rule|max_age_in_seconds| The number of seconds the client should cache a preflight response.|||True|
|queue_properties|logging| A `logging` block as defined below.|||False|
|logging|delete| Indicates whether all delete requests should be logged. Changing this forces a new resource.|||True|
|logging|read| Indicates whether all read requests should be logged. Changing this forces a new resource.|||True|
|logging|version| The version of storage analytics to configure. Changing this forces a new resource.|||True|
|logging|write| Indicates whether all write requests should be logged. Changing this forces a new resource.|||True|
|logging|retention_policy_days| Specifies the number of days that logs will be retained. Changing this forces a new resource.|||False|
|queue_properties|minute_metrics| A `minute_metrics` block as defined below.|||False|
|minute_metrics|enabled| Indicates whether minute metrics are enabled for the Queue service. Changing this forces a new resource.|||True|
|minute_metrics|version| The version of storage analytics to configure. Changing this forces a new resource.|||True|
|minute_metrics|include_apis| Indicates whether metrics should generate summary statistics for called API operations.|||False|
|minute_metrics|retention_policy_days| Specifies the number of days that logs will be retained. Changing this forces a new resource.|||False|
|queue_properties|hour_metrics| A `hour_metrics` block as defined below.|||False|
|hour_metrics|enabled| Indicates whether hour metrics are enabled for the Queue service. Changing this forces a new resource.|||True|
|hour_metrics|version| The version of storage analytics to configure. Changing this forces a new resource.|||True|
|hour_metrics|include_apis| Indicates whether metrics should generate summary statistics for called API operations.|||False|
|hour_metrics|retention_policy_days| Specifies the number of days that logs will be retained. Changing this forces a new resource.|||False|
|static_website|index_document| The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive.|||False|
|static_website|error_404_document| The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file.|||False|
|static_website|index_document| The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive.|||False|
|static_website|error_404_document| The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file.|||False|
|network_rules|default_action| Specifies the default action of allow or deny when no other rules match. Valid options are `Deny` or `Allow`.|||True|
|network_rules|bypass|  Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are|||False|
|network_rules|ip_rules| List of public IP or IP ranges in CIDR Format. Only IPV4 addresses are allowed. Private IP address ranges (as defined in [RFC 1918](https://tools.ietf.org/html/rfc1918#section-3)) are not allowed.|||False|
|network_rules|virtual_network_subnet_ids| A list of resource ids for subnets.|||False|
|network_rules|private_link_access| One or More `private_link_access` block as defined below.|||False|
|private_link_access|endpoint_resource_id| The resource id of the resource access rule to be granted access.|||True|
|private_link_access|endpoint_tenant_id| The tenant id of the resource of the resource access rule to be granted access. Defaults to the current tenant id.|||False|
|azure_files_authentication|directory_type| Specifies the directory service used. Possible values are `AADDS` and `AD`.|||True|
|azure_files_authentication|active_directory| A `active_directory` block as defined below. Required when `directory_type` is `AD`.|||False|
|active_directory|storage_sid| Specifies the security identifier (SID) for Azure Storage.|||True|
|active_directory|domain_name| Specifies the primary domain that the AD DNS server is authoritative for.|||True|
|active_directory|domain_sid| Specifies the security identifier (SID).|||True|
|active_directory|domain_guid| Specifies the domain GUID.|||True|
|active_directory|forest_name| Specifies the Active Directory forest.|||True|
|active_directory|netbios_domain_name| Specifies the NetBIOS domain name.|||True|
|routing|publish_internet_endpoints| Should internet routing storage endpoints be published? Defaults to `false`.|||False|
|routing|publish_microsoft_endpoints| Should microsoft routing storage endpoints be published? Defaults to `false`.|||False|
|routing|choice| Specifies the kind of network routing opted by the user. Possible values are `InternetRouting` and `MicrosoftRouting`. Defaults to `MicrosoftRouting`.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Storage Account.|||
|primary_location|The primary location of the storage account.|||
|secondary_location|The secondary location of the storage account.|||
|primary_blob_endpoint|The endpoint URL for blob storage in the primary location.|||
|primary_blob_host|The hostname with port if applicable for blob storage in the primary location.|||
|secondary_blob_endpoint|The endpoint URL for blob storage in the secondary location.|||
|secondary_blob_host|The hostname with port if applicable for blob storage in the secondary location.|||
|primary_queue_endpoint|The endpoint URL for queue storage in the primary location.|||
|primary_queue_host|The hostname with port if applicable for queue storage in the primary location.|||
|secondary_queue_endpoint|The endpoint URL for queue storage in the secondary location.|||
|secondary_queue_host|The hostname with port if applicable for queue storage in the secondary location.|||
|primary_table_endpoint|The endpoint URL for table storage in the primary location.|||
|primary_table_host|The hostname with port if applicable for table storage in the primary location.|||
|secondary_table_endpoint|The endpoint URL for table storage in the secondary location.|||
|secondary_table_host|The hostname with port if applicable for table storage in the secondary location.|||
|primary_file_endpoint|The endpoint URL for file storage in the primary location.|||
|primary_file_host|The hostname with port if applicable for file storage in the primary location.|||
|secondary_file_endpoint|The endpoint URL for file storage in the secondary location.|||
|secondary_file_host|The hostname with port if applicable for file storage in the secondary location.|||
|primary_dfs_endpoint|The endpoint URL for DFS storage in the primary location.|||
|primary_dfs_host|The hostname with port if applicable for DFS storage in the primary location.|||
|secondary_dfs_endpoint|The endpoint URL for DFS storage in the secondary location.|||
|secondary_dfs_host|The hostname with port if applicable for DFS storage in the secondary location.|||
|primary_web_endpoint|The endpoint URL for web storage in the primary location.|||
|primary_web_host|The hostname with port if applicable for web storage in the primary location.|||
|secondary_web_endpoint|The endpoint URL for web storage in the secondary location.|||
|secondary_web_host|The hostname with port if applicable for web storage in the secondary location.|||
|primary_access_key|The primary access key for the storage account.|||
|secondary_access_key|The secondary access key for the storage account.|||
|primary_connection_string|The connection string associated with the primary location.|||
|secondary_connection_string|The connection string associated with the secondary location.|||
|primary_blob_connection_string|The connection string associated with the primary blob location.|||
|secondary_blob_connection_string|The connection string associated with the secondary blob location.|||
|identity|An `identity` block as defined below, which contains the Identity information for this Storage Account.|||
