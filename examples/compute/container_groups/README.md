module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# container_group

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Container Group. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|identity| An `identity` block as defined below.| Block |False|
|container| The definition of a container that is part of the group as documented in the `container` block below. Changing this forces a new resource to be created.| Block |True|
|os_type| The OS for the container group. Allowed values are `Linux` and `Windows`. Changing this forces a new resource to be created.||True|
|dns_config| A `dns_config` block as documented below.| Block |False|
|diagnostics| A `diagnostics` block as documented below.| Block |False|
|dns_name_label| The DNS label/name for the container groups IP. Changing this forces a new resource to be created.||False|
|exposed_port| Zero or more `exposed_port` blocks as defined below. Changing this forces a new resource to be created. | Block |False|
|ip_address_type| Specifies the ip address type of the container. `Public`, `Private` or `None`. Changing this forces a new resource to be created. If set to `Private`, `network_profile_id` also needs to be set.||False|
|dns_name_label| The DNS label/name for the container groups IP. Changing this forces a new resource to be created.||False|
|network_profile|The `network_profile` block as defined below.|Block|False|
|image_registry_credential| A `image_registry_credential` block as documented below. Changing this forces a new resource to be created.| Block |False|
|restart_policy| Restart policy for the container group. Allowed values are `Always`, `Never`, `OnFailure`. Defaults to `Always`. Changing this forces a new resource to be created.||False|
|tags| A mapping of tags to assign to the resource.||False|
|type| The Managed Service Identity Type of this container group. Possible values are `SystemAssigned` (where Azure will generate a Service Principal for you), `UserAssigned` where you can specify the Service Principal IDs in the `identity_ids` field, and `SystemAssigned, UserAssigned` which assigns both a system managed identity as well as the specified user assigned identities. Changing this forces a new resource to be created.||True|
|identity_ids| Specifies a list of user managed identity ids to be assigned. Required if `type` is `UserAssigned`. Changing this forces a new resource to be created.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|identity|type| The Managed Service Identity Type of this container group. Possible values are `SystemAssigned` (where Azure will generate a Service Principal for you), `UserAssigned` where you can specify the Service Principal IDs in the `identity_ids` field, and `SystemAssigned, UserAssigned` which assigns both a system managed identity as well as the specified user assigned identities. Changing this forces a new resource to be created.|||True|
|identity|identity_ids| Specifies a list of user managed identity ids to be assigned. Required if `type` is `UserAssigned`. Changing this forces a new resource to be created.|||False|
|container|name| Specifies the name of the Container. Changing this forces a new resource to be created.|||True|
|container|image| The container image name. Changing this forces a new resource to be created.|||True|
|container|cpu| The required number of CPU cores of the containers. Changing this forces a new resource to be created.|||True|
|container|memory| The required memory of the containers in GB. Changing this forces a new resource to be created.|||True|
|container|gpu| A `gpu` block as defined below. Changing this forces a new resource to be created.|||False|
|gpu|count| The number of GPUs which should be assigned to this container. Allowed values are `1`, `2`, or `4`. Changing this forces a new resource to be created.|||True|
|gpu|sku| The Sku which should be used for the GPU. Possible values are `K80`, `P100`, or `V100`. Changing this forces a new resource to be created.|||True|
|container|ports| A set of public ports for the container. Changing this forces a new resource to be created. Set as documented in the `ports` block below.|||False|
|ports|port| The port number the container will expose. Changing this forces a new resource to be created.|||True|
|ports|protocol| The network protocol associated with port. Possible values are `TCP` & `UDP`. Changing this forces a new resource to be created.|||True|
|container|environment_variables| A list of environment variables to be set on the container. Specified as a map of name/value pairs. Changing this forces a new resource to be created.|||False|
|container|secure_environment_variables| A list of sensitive environment variables to be set on the container. Specified as a map of name/value pairs. Changing this forces a new resource to be created.|||False|
|container|readiness_probe| The definition of a readiness probe for this container as documented in the `readiness_probe` block below. Changing this forces a new resource to be created.|||False|
|readiness_probe|exec| Commands to be run to validate container readiness. Changing this forces a new resource to be created.|||False|
|readiness_probe|http_get| The definition of the http_get for this container as documented in the `http_get` block below. Changing this forces a new resource to be created.|||False|
|http_get|path| Path to access on the HTTP server. Changing this forces a new resource to be created.|||False|
|http_get|port| Number of the port to access on the container. Changing this forces a new resource to be created.|||False|
|http_get|scheme| Scheme to use for connecting to the host. Possible values are `Http` and `Https`. Changing this forces a new resource to be created.|||False|
|readiness_probe|initial_delay_seconds| Number of seconds after the container has started before liveness or readiness probes are initiated. Changing this forces a new resource to be created.|||False|
|readiness_probe|period_seconds| How often (in seconds) to perform the probe. The default value is `10` and the minimum value is `1`. Changing this forces a new resource to be created.|||False|
|readiness_probe|failure_threshold| How many times to try the probe before restarting the container (liveness probe) or marking the container as unhealthy (readiness probe). The default value is `3` and the minimum value is `1`. Changing this forces a new resource to be created.|||False|
|readiness_probe|success_threshold| Minimum consecutive successes for the probe to be considered successful after having failed. The default value is `1` and the minimum value is `1`. Changing this forces a new resource to be created.|||False|
|readiness_probe|timeout_seconds| Number of seconds after which the probe times out. The default value is `1` and the minimum value is `1`. Changing this forces a new resource to be created.|||False|
|container|liveness_probe| The definition of a readiness probe for this container as documented in the `liveness_probe` block below. Changing this forces a new resource to be created.|||False|
|liveness_probe|exec| Commands to be run to validate container readiness. Changing this forces a new resource to be created.|||False|
|liveness_probe|http_get| The definition of the http_get for this container as documented in the `http_get` block below. Changing this forces a new resource to be created.|||False|
|http_get|path| Path to access on the HTTP server. Changing this forces a new resource to be created.|||False|
|http_get|port| Number of the port to access on the container. Changing this forces a new resource to be created.|||False|
|http_get|scheme| Scheme to use for connecting to the host. Possible values are `Http` and `Https`. Changing this forces a new resource to be created.|||False|
|liveness_probe|initial_delay_seconds| Number of seconds after the container has started before liveness or readiness probes are initiated. Changing this forces a new resource to be created.|||False|
|liveness_probe|period_seconds| How often (in seconds) to perform the probe. The default value is `10` and the minimum value is `1`. Changing this forces a new resource to be created.|||False|
|liveness_probe|failure_threshold| How many times to try the probe before restarting the container (liveness probe) or marking the container as unhealthy (readiness probe). The default value is `3` and the minimum value is `1`. Changing this forces a new resource to be created.|||False|
|liveness_probe|success_threshold| Minimum consecutive successes for the probe to be considered successful after having failed. The default value is `1` and the minimum value is `1`. Changing this forces a new resource to be created.|||False|
|liveness_probe|timeout_seconds| Number of seconds after which the probe times out. The default value is `1` and the minimum value is `1`. Changing this forces a new resource to be created.|||False|
|container|commands| A list of commands which should be run on the container. Changing this forces a new resource to be created.|||False|
|container|volume| The definition of a volume mount for this container as documented in the `volume` block below. Changing this forces a new resource to be created.|||False|
|volume|name| The name of the volume mount. Changing this forces a new resource to be created.|||True|
|volume|mount_path| The path on which this volume is to be mounted. Changing this forces a new resource to be created.|||True|
|volume|read_only| Specify if the volume is to be mounted as read only or not. The default value is `false`. Changing this forces a new resource to be created.|||False|
|volume|empty_dir| Boolean as to whether the mounted volume should be an empty directory. Defaults to `false`. Changing this forces a new resource to be created.|||False|
|volume|storage_account_name| The Azure storage account from which the volume is to be mounted. Changing this forces a new resource to be created.|||False|
|volume|storage_account_key| The access key for the Azure Storage account specified as above. Changing this forces a new resource to be created.|||False|
|volume|share_name| The Azure storage share that is to be mounted as a volume. This must be created on the storage account specified as above. Changing this forces a new resource to be created.|||False|
|volume|git_repo| A `git_repo` block as defined below.|||False|
|git_repo|url| Specifies the Git repository to be cloned. Changing this forces a new resource to be created.|||True|
|git_repo|directory| Specifies the directory into which the repository should be cloned. Changing this forces a new resource to be created.|||False|
|git_repo|revision| Specifies the commit hash of the revision to be cloned. If unspecified, the HEAD revision is cloned. Changing this forces a new resource to be created.|||False|
|volume|secret| A map of secrets that will be mounted as files in the volume. Changing this forces a new resource to be created.|||False|
|dns_config|nameservers| A list of nameservers the containers will search out to resolve requests.|||True|
|dns_config|search_domains| A list of search domains that DNS requests will search along.|||False|
|dns_config|options| A list of [resolver configuration options](https://man7.org/linux/man-pages/man5/resolv.conf.5.html).|||False|
|diagnostics|log_analytics| A `log_analytics` block as defined below. Changing this forces a new resource to be created.|||True|
|log_analytics|log_type| The log type which should be used. Possible values are `ContainerInsights` and `ContainerInstanceLogs`. Changing this forces a new resource to be created.|||False|
|log_analytics|workspace_id| The Workspace ID of the Log Analytics Workspace. Changing this forces a new resource to be created.|||True|
|log_analytics|workspace_key| The Workspace Key of the Log Analytics Workspace. Changing this forces a new resource to be created.|||True|
|log_analytics|metadata| Any metadata required for Log Analytics. Changing this forces a new resource to be created.|||False|
|exposed_port|port| The port number the container will expose. Changing this forces a new resource to be created.|||True|
|exposed_port|protocol| The network protocol associated with port. Possible values are `TCP` & `UDP`. Changing this forces a new resource to be created.|||True|
|network_profile| key | Key for  network_profile||| Required if  |
|network_profile| lz_key |Landing Zone Key in wich the network_profile is located|||False|
|network_profile| id | The id of the network_profile |||False|
|image_registry_credential|username| The username with which to connect to the registry. Changing this forces a new resource to be created.|||True|
|image_registry_credential|password| The password with which to connect to the registry. Changing this forces a new resource to be created.|||True|
|image_registry_credential|server| The address to use to connect to the registry without protocol ("https"/"http"). For example: "myacr.acr.io". Changing this forces a new resource to be created.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Container Group.|||
|ip_address|The IP address allocated to the container group.|||
|fqdn|The FQDN of the container group derived from `dns_name_label`.|||
