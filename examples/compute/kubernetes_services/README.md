# Azure Kubernetes Services

This sub module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this module inside your Terraform code either as a module or as a sub module directly from the [Terraform Registry](https://registry.terraform.io/modules/aztfmod/caf/azurerm/latest) using the following calls:

Complete module:
```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "4.21.2"
  # insert the 6 required variables here
}
```
## Example scenarios

The following examples are available:

| Scenario                                     | Description                                                                                      |
|----------------------------------------------|--------------------------------------------------------------------------------------------------|
| [101-single-cluster](./101-single-cluster)   | Simple example for AKS cluster with public IP load balancer.                                     |
| [102-multi-nodepools](./102-multi-nodepools) | Simple example for AKS cluster with public IP load balancer and multiple node pools.             |
| [103-multi-clusters](./103-multi-clusters)   | Simple example for multi regions AKS clusters with public IP load balancer, multiple node pools. |
| [104-private-cluster](./104-private-cluster) | Simple example for private AKS clusters.                                                         |

## Run this example

You can run this example directly using Terraform or via rover:

### With Terraform

```bash
#Login to your Azure subscription
az login

#Run the example
cd /tf/caf/examples/compute/kubernetes_services/101-single-cluster/standalone

terraform init

terraform [plan | apply | destroy] \
  -var-file ../aks.tfvars \
  -var-file ../networking.tfvars
```

### With rover

To test this deployment in the example landingzone, make sure the launchpad has been deployed first, then run the following command:

```bash
rover \
  -lz /tf/caf/landingzones/caf_example \
  -var-folder  /tf/caf/modules/aks/examples/101-single-cluster/ \
  -level level1 \
  -a [plan | apply | destroy]
```

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# kubernetes_cluster

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the Managed Kubernetes Cluster to create. Changing this forces a new resource to be created.||True|
| region |The region_key where the resource will be deployed|String|True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|default_node_pool| A `default_node_pool` block as defined below.| Block |True|
|dns_prefix| DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created.||False|
|dns_prefix_private_cluster| Specifies the DNS prefix to use with private clusters. Changing this forces a new resource to be created.||False|
|automatic_channel_upgrade| The upgrade channel for this Kubernetes Cluster. Possible values are `patch`, `rapid`, `node-image` and `stable`. Omitting this field sets this value to `none`.||False|
|addon_profile| A `addon_profile` block as defined below.| Block |False|
|api_server_authorized_ip_ranges| The IP ranges to allow for incoming traffic to the server nodes.||False|
|auto_scaler_profile| A `auto_scaler_profile` block as defined below.| Block |False|
|disk_encryption_set|The `disk_encryption_set` block as defined below.|Block|False|
|http_proxy_config| A `http_proxy_config` block as defined below.| Block |False|
|identity| An `identity` block as defined below. One of either `identity` or `service_principal` must be specified.| Block |False|
|kubelet_identity|A `kubelet_identity` block as defined below. Changing this forces a new resource to be created.| Block |False|
|kubernetes_version| Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade).||False|
|linux_profile| A `linux_profile` block as defined below.| Block |False|
|local_account_disabled| - If `true` local accounts will be disabled. Defaults to `false`. See [the documentation](https://docs.microsoft.com/en-us/azure/aks/managed-aad#disable-local-accounts) for more information.||False|
|maintenance_window| A `maintenance_window` block as defined below.| Block |False|
|network_profile| A `network_profile` block as defined below.| Block |False|
|node_resource_group| The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created.||False|
|private_cluster_enabled|Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to `false`. Changing this forces a new resource to be created.||False|
|private_dns_zone|The `private_dns_zone` block as defined below.|Block|False|
|private_cluster_public_fqdn_enabled| Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to `false`.||False|
|role_based_access_control| A `role_based_access_control` block. Changing this forces a new resource to be created.| Block |False|
|service_principal| A `service_principal` block as documented below. One of either `identity` or `service_principal` must be specified. | Block |False|
|sku_tier| The SKU Tier that should be used for this Kubernetes Cluster. Possible values are `Free` and `Paid` (which includes the Uptime SLA). Defaults to `Free`.||False|
|tags| A mapping of tags to assign to the resource.||False|
|windows_profile| A `windows_profile` block as defined below.| Block |False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|default_node_pool|name| The name which should be used for the default Kubernetes Node Pool. Changing this forces a new resource to be created.|||True|
|default_node_pool|vm_size| The size of the Virtual Machine, such as `Standard_DS2_v2`.|||True|
|default_node_pool|availability_zones| A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created.|||False|
|default_node_pool|enable_auto_scaling| Should [the Kubernetes Auto Scaler](https://docs.microsoft.com/en-us/azure/aks/cluster-autoscaler) be enabled for this Node Pool? Defaults to `false`.|||False|
|default_node_pool|enable_host_encryption| Should the nodes in the Default Node Pool have host encryption enabled? Defaults to `false`.|||False|
|default_node_pool|enable_node_public_ip| Should nodes in this Node Pool have a Public IP Address? Defaults to `false`. Changing this forces a new resource to be created.|||False|
|default_node_pool|kubelet_config| A `kubelet_config` block as defined below.|||False|
|kubelet_config|allowed_unsafe_sysctls| Specifies the allow list of unsafe sysctls command or patterns (ending in `*`). Changing this forces a new resource to be created.|||False|
|kubelet_config|container_log_max_line| Specifies the maximum number of container log files that can be present for a container. must be at least 2. Changing this forces a new resource to be created.|||False|
|kubelet_config|container_log_max_size_mb| Specifies the maximum size (e.g. 10MB) of container log file before it is rotated. Changing this forces a new resource to be created.|||False|
|kubelet_config|cpu_cfs_quota_enabled| Is CPU CFS quota enforcement for containers enabled? Changing this forces a new resource to be created.|||False|
|kubelet_config|cpu_cfs_quota_period| Specifies the CPU CFS quota period value. Changing this forces a new resource to be created.|||False|
|kubelet_config|cpu_manager_policy| Specifies the CPU Manager policy to use. Possible values are `none` and `static`, Changing this forces a new resource to be created.|||False|
|kubelet_config|image_gc_high_threshold| Specifies the percent of disk usage above which image garbage collection is always run. Must be between `0` and `100`. Changing this forces a new resource to be created.|||False|
|kubelet_config|image_gc_low_threshold| Specifies the percent of disk usage lower than which image garbage collection is never run. Must be between `0` and `100`. Changing this forces a new resource to be created.|||False|
|kubelet_config|pod_max_pid| Specifies the maximum number of processes per pod. Changing this forces a new resource to be created.|||False|
|kubelet_config|topology_manager_policy| Specifies the Topology Manager policy to use. Possible values are `none`, `best-effort`, `restricted` or `single-numa-node`. Changing this forces a new resource to be created.|||False|
|default_node_pool|linux_os_config| A `linux_os_config` block as defined below.|||False|
|linux_os_config|swap_file_size_mb| Specifies the size of swap file on each node in MB. Changing this forces a new resource to be created.|||False|
|linux_os_config|sysctl_config| A `sysctl_config` block as defined below. Changing this forces a new resource to be created.|||False|
|sysctl_config|fs_aio_max_nr| The sysctl setting fs.aio-max-nr. Must be between `65536` and `6553500`. Changing this forces a new resource to be created.|||False|
|sysctl_config|fs_file_max| The sysctl setting fs.file-max. Must be between `8192` and `12000500`. Changing this forces a new resource to be created.|||False|
|sysctl_config|fs_inotify_max_user_watches| The sysctl setting fs.inotify.max_user_watches. Must be between `781250` and `2097152`. Changing this forces a new resource to be created.|||False|
|sysctl_config|fs_nr_open| The sysctl setting fs.nr_open. Must be between `8192` and `20000500`. Changing this forces a new resource to be created.|||False|
|sysctl_config|kernel_threads_max| The sysctl setting kernel.threads-max. Must be between `20` and `513785`. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_core_netdev_max_backlog| The sysctl setting net.core.netdev_max_backlog. Must be between `1000` and `3240000`. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_core_optmem_max| The sysctl setting net.core.optmem_max. Must be between `20480` and `4194304`. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_core_rmem_default| The sysctl setting net.core.rmem_default. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_core_rmem_max| The sysctl setting net.core.rmem_max. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_core_somaxconn| The sysctl setting net.core.somaxconn. Must be between `4096` and `3240000`. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_core_wmem_default| The sysctl setting net.core.wmem_default. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_core_wmem_max| The sysctl setting net.core.wmem_max. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_ipv4_ip_local_port_range_max| The sysctl setting net.ipv4.ip_local_port_range max value. Must be between `1024` and `60999`. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_ipv4_ip_local_port_range_min| The sysctl setting net.ipv4.ip_local_port_range min value. Must be between `1024` and `60999`. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_ipv4_neigh_default_gc_thresh1| The sysctl setting net.ipv4.neigh.default.gc_thresh1. Must be between `128` and `80000`. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_ipv4_neigh_default_gc_thresh2| The sysctl setting net.ipv4.neigh.default.gc_thresh2. Must be between `512` and `90000`. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_ipv4_neigh_default_gc_thresh3| The sysctl setting net.ipv4.neigh.default.gc_thresh3. Must be between `1024` and `100000`. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_ipv4_tcp_fin_timeout| The sysctl setting net.ipv4.tcp_fin_timeout. Must be between `5` and `120`. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_ipv4_tcp_keepalive_intvl| The sysctl setting net.ipv4.tcp_keepalive_intvl. Must be between `10` and `75`. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_ipv4_tcp_keepalive_probes| The sysctl setting net.ipv4.tcp_keepalive_probes. Must be between `1` and `15`. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_ipv4_tcp_keepalive_time| The sysctl setting net.ipv4.tcp_keepalive_time. Must be between `30` and `432000`. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_ipv4_tcp_max_syn_backlog| The sysctl setting net.ipv4.tcp_max_syn_backlog. Must be between `128` and `3240000`. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_ipv4_tcp_max_tw_buckets| The sysctl setting net.ipv4.tcp_max_tw_buckets. Must be between `8000` and `1440000`. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_ipv4_tcp_tw_reuse| The sysctl setting net.ipv4.tcp_tw_reuse. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_netfilter_nf_conntrack_buckets| The sysctl setting net.netfilter.nf_conntrack_buckets. Must be between `65536` and `147456`. Changing this forces a new resource to be created.|||False|
|sysctl_config|net_netfilter_nf_conntrack_max| The sysctl setting net.netfilter.nf_conntrack_max. Must be between `131072` and `589824`. Changing this forces a new resource to be created.|||False|
|sysctl_config|vm_max_map_count| The sysctl setting vm.max_map_count. Must be between `65530` and `262144`. Changing this forces a new resource to be created.|||False|
|sysctl_config|vm_swappiness| The sysctl setting vm.swappiness. Must be between `0` and `100`. Changing this forces a new resource to be created.|||False|
|sysctl_config|vm_vfs_cache_pressure| The sysctl setting vm.vfs_cache_pressure. Must be between `0` and `100`. Changing this forces a new resource to be created.|||False|
|linux_os_config|transparent_huge_page_defrag| specifies the defrag configuration for Transparent Huge Page. Possible values are `always`, `defer`, `defer+madvise`, `madvise` and `never`. Changing this forces a new resource to be created.|||False|
|linux_os_config|transparent_huge_page_enabled| Specifies the Transparent Huge Page enabled configuration. Possible values are `always`, `madvise` and `never`. Changing this forces a new resource to be created.|||False|
|default_node_pool|fips_enabled| Should the nodes in this Node Pool have Federal Information Processing Standard enabled? Changing this forces a new resource to be created.|||False|
|default_node_pool|kubelet_disk_type| The type of disk used by kubelet. At this time the only possible value is `OS`.|||False|
|default_node_pool|max_pods| The maximum number of pods that can run on each agent. Changing this forces a new resource to be created.|||False|
|default_node_pool|node_public_ip_prefix_id| Resource ID for the Public IP Addresses Prefix for the nodes in this Node Pool. `enable_node_public_ip` should be `true`. Changing this forces a new resource to be created.|||False|
|default_node_pool|node_labels| A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. Changing this forces a new resource to be created.|||False|
|default_node_pool|only_critical_addons_enabled| Enabling this option will taint default node pool with `CriticalAddonsOnly=true:NoSchedule` taint. Changing this forces a new resource to be created.|||False|
|default_node_pool|orchestrator_version| Version of Kubernetes used for the Agents. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade)|||False|
|default_node_pool|os_disk_size_gb| The size of the OS Disk which should be used for each agent in the Node Pool. Changing this forces a new resource to be created.|||False|
|default_node_pool|os_disk_type| The type of disk which should be used for the Operating System. Possible values are `Ephemeral` and `Managed`. Defaults to `Managed`. Changing this forces a new resource to be created.|||False|
|default_node_pool|os_sku| OsSKU to be used to specify Linux OSType. Not applicable to Windows OSType. Possible values include: `Ubuntu`, `CBLMariner`. Defaults to `Ubuntu`. Changing this forces a new resource to be created.|||False|
|default_node_pool|pod_subnet_id| The ID of the Subnet where the pods in the default Node Pool should exist. Changing this forces a new resource to be created.|||False|
|default_node_pool|type| The type of Node Pool which should be created. Possible values are `AvailabilitySet` and `VirtualMachineScaleSets`. Defaults to `VirtualMachineScaleSets`.|||False|
|default_node_pool|tags| A mapping of tags to assign to the Node Pool.|||False|
|default_node_pool|ultra_ssd_enabled| Used to specify whether the UltraSSD is enabled in the Default Node Pool. Defaults to `false`. See [the documentation](https://docs.microsoft.com/en-us/azure/aks/use-ultra-disks) for more information.|||False|
|default_node_pool|upgrade_settings| A `upgrade_settings` block as documented below.|||False|
|upgrade_settings|max_surge| The maximum number or percentage of nodes which will be added to the Node Pool size during an upgrade.|||True|
|default_node_pool|vnet_subnet_id| The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created.|||False|
|default_node_pool|max_count| The maximum number of nodes which should exist in this Node Pool. If specified this must be between `1` and `1000`.|||True|
|default_node_pool|min_count| The minimum number of nodes which should exist in this Node Pool. If specified this must be between `1` and `1000`.|||True|
|default_node_pool|node_count| The initial number of nodes which should exist in this Node Pool. If specified this must be between `1` and `1000` and between `min_count` and `max_count`.|||False|
|default_node_pool|node_count| The initial number of nodes which should exist in this Node Pool. If specified this must be between `1` and `1000` and between `min_count` and `max_count`.|||False|
|addon_profile|aci_connector_linux| A `aci_connector_linux` block. For more details, please visit [Create and configure an AKS cluster to use virtual nodes](https://docs.microsoft.com/en-us/azure/aks/virtual-nodes-portal).|||False|
|aci_connector_linux|enabled| Is the virtual node addon enabled?|||True|
|aci_connector_linux|subnet_name| The subnet name for the virtual nodes to run. This is required when `aci_connector_linux` `enabled` argument is set to `true`.|||False|
|addon_profile|azure_policy| A `azure_policy` block as defined below. For more details please visit [Understand Azure Policy for Azure Kubernetes Service](https://docs.microsoft.com/en-ie/azure/governance/policy/concepts/rego-for-aks)|||False|
|azure_policy|enabled| Is the Azure Policy for Kubernetes Add On enabled?|||True|
|addon_profile|http_application_routing| A `http_application_routing` block as defined below.|||False|
|http_application_routing|enabled||||False|
|addon_profile|kube_dashboard| A `kube_dashboard` block as defined below.|||False|
|kube_dashboard|enabled| Is the Kubernetes Dashboard enabled?|||True|
|addon_profile|oms_agent| A `oms_agent` block as defined below. For more details, please visit [How to onboard Azure Monitor for containers](https://docs.microsoft.com/en-us/azure/monitoring/monitoring-container-insights-onboard).|||False|
|oms_agent|enabled| Is the OMS Agent Enabled?|||True|
|oms_agent|log_analytics_workspace_id| The ID of the Log Analytics Workspace which the OMS Agent should send data to. Must be present if `enabled` is `true`.|||False|
|addon_profile|ingress_application_gateway| An `ingress_application_gateway` block as defined below.|||False|
|ingress_application_gateway|enabled| Whether to deploy the Application Gateway ingress controller to this Kubernetes Cluster?|||True|
|ingress_application_gateway|gateway_id| The ID of the Application Gateway to integrate with the ingress controller of this Kubernetes Cluster. See [this](https://docs.microsoft.com/en-us/azure/application-gateway/tutorial-ingress-controller-add-on-existing) page for further details.|||False|
|ingress_application_gateway|gateway_name| The name of the Application Gateway to be used or created in the Nodepool Resource Group, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. See [this](https://docs.microsoft.com/en-us/azure/application-gateway/tutorial-ingress-controller-add-on-new) page for further details.|||False|
|ingress_application_gateway|subnet_cidr| The subnet CIDR to be used to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. See [this](https://docs.microsoft.com/en-us/azure/application-gateway/tutorial-ingress-controller-add-on-new) page for further details.|||False|
|ingress_application_gateway|subnet_id| The ID of the subnet on which to create an Application Gateway, which in turn will be integrated with the ingress controller of this Kubernetes Cluster. See [this](https://docs.microsoft.com/en-us/azure/application-gateway/tutorial-ingress-controller-add-on-new) page for further details.|||False|
|addon_profile|open_service_mesh| An `open_service_mesh` block as defined below. For more details, please visit [Open Service Mesh for AKS](https://docs.microsoft.com/azure/aks/open-service-mesh-about).|||False|
|open_service_mesh|enabled|Is Open Service Mesh enabled?|||False|
|addon_profile|azure_keyvault_secrets_provider| An `azure_keyvault_secrets_provider` block as defined below. For more details, please visit [Azure Keyvault Secrets Provider for AKS](https://docs.microsoft.com/en-us/azure/aks/csi-secrets-store-driver).|||False|
|azure_keyvault_secrets_provider|enabled|Is the Azure Keyvault Secrets Providerenabled?|||False|
|azure_keyvault_secrets_provider|secret_rotation_enabled| Is secret rotation enabled?|||False|
|azure_keyvault_secrets_provider|secret_rotation_interval| The interval to poll for secret rotation. This attribute is only set when `secret_rotation` is true and defaults to `2m`.|||False|
|auto_scaler_profile|balance_similar_node_groups|Detect similar node groups and balance the number of nodes between them. Defaults to `false`.|||False|
|auto_scaler_profile|expander|Expander to use. Possible values are `least-waste`, `priority`, `most-pods` and `random`. Defaults to `random`.|||False|
|auto_scaler_profile|max_graceful_termination_sec|Maximum number of seconds the cluster autoscaler waits for pod termination when trying to scale down a node. Defaults to `600`.|||False|
|auto_scaler_profile|max_node_provisioning_time|Maximum time the autoscaler waits for a node to be provisioned. Defaults to `15m`.|||False|
|auto_scaler_profile|max_unready_nodes|Maximum Number of allowed unready nodes. Defaults to `3`.|||False|
|auto_scaler_profile|max_unready_percentage|Maximum percentage of unready nodes the cluster autoscaler will stop if the percentage is exceeded. Defaults to `45`.|||False|
|auto_scaler_profile|new_pod_scale_up_delay|For scenarios like burst/batch scale where you don't want CA to act before the kubernetes scheduler could schedule all the pods, you can tell CA to ignore unscheduled pods before they're a certain age. Defaults to `10s`.|||False|
|auto_scaler_profile|scale_down_delay_after_add|How long after the scale up of AKS nodes the scale down evaluation resumes. Defaults to `10m`.|||False|
|auto_scaler_profile|scale_down_delay_after_delete|How long after node deletion that scale down evaluation resumes. Defaults to the value used for `scan_interval`.|||False|
|auto_scaler_profile|scale_down_delay_after_failure|How long after scale down failure that scale down evaluation resumes. Defaults to `3m`.|||False|
|auto_scaler_profile|scan_interval|How often the AKS Cluster should be re-evaluated for scale up/down. Defaults to `10s`.|||False|
|auto_scaler_profile|scale_down_unneeded|How long a node should be unneeded before it is eligible for scale down. Defaults to `10m`.|||False|
|auto_scaler_profile|scale_down_unready|How long an unready node should be unneeded before it is eligible for scale down. Defaults to `20m`.|||False|
|auto_scaler_profile|scale_down_utilization_threshold|Node utilization level, defined as sum of requested resources divided by capacity, below which a node can be considered for scale down. Defaults to `0.5`.|||False|
|auto_scaler_profile|empty_bulk_delete_max|Maximum number of empty nodes that can be deleted at the same time. Defaults to `10`.|||False|
|auto_scaler_profile|skip_nodes_with_local_storage|If `true` cluster autoscaler will never delete nodes with pods with local storage, for example, EmptyDir or HostPath. Defaults to `true`.|||False|
|auto_scaler_profile|skip_nodes_with_system_pods|If `true` cluster autoscaler will never delete nodes with pods from kube-system (except for DaemonSet or mirror pods). Defaults to `true`.|||False|
|disk_encryption_set| key | Key for  disk_encryption_set||| Required if  |
|disk_encryption_set| lz_key |Landing Zone Key in wich the disk_encryption_set is located|||False|
|disk_encryption_set| id | The id of the disk_encryption_set |||False|
|http_proxy_config|http_proxy| The proxy address to be used when communicating over HTTP.|||False|
|http_proxy_config|https_proxy| The proxy address to be used when communicating over HTTPS.|||False|
|http_proxy_config|no_proxy| The list of domains that will not use the proxy for communication.|||False|
|http_proxy_config|trusted_ca| The base64 encoded alternative CA certificate content in PEM format.|||False|
|identity|type|The type of identity used for the managed cluster. Possible values are `SystemAssigned` and `UserAssigned`. If `UserAssigned` is set, a `user_assigned_identity_id` must be set as well.|||False|
|identity|user_assigned_identity_id| The ID of a user assigned identity.|||False|
|kubelet_identity|client_id| The Client ID of the user-defined Managed Identity to be assigned to the Kubelets. If not specified a Managed Identity is created automatically.|||True|
|kubelet_identity|object_id| The Object ID of the user-defined Managed Identity assigned to the Kubelets.If not specified a Managed Identity is created automatically.|||True|
|kubelet_identity|user_assigned_identity_id| The ID of the User Assigned Identity assigned to the Kubelets. If not specified a Managed Identity is created automatically. |||True|
|linux_profile|admin_username| The Admin Username for the Cluster. Changing this forces a new resource to be created.|||True|
|linux_profile|ssh_key| An `ssh_key` block. Only one is currently allowed. Changing this forces a new resource to be created.|||True|
|ssh_key|key_data| The Public SSH Key used to access the cluster. Changing this forces a new resource to be created.|||True|
|maintenance_window|allowed| One or more `allowed` block as defined below.|||False|
|maintenance_window|not_allowed| One or more `not_allowed` block as defined below.|||False|
|network_profile|network_plugin| Network plugin to use for networking. Currently supported values are `azure` and `kubenet`. Changing this forces a new resource to be created.|||True|
|network_profile|network_mode| Network mode to be used with Azure CNI. Possible values are `bridge` and `transparent`. Changing this forces a new resource to be created.|||False|
|network_profile|network_mode| Network mode to be used with Azure CNI. Possible values are `bridge` and `transparent`. Changing this forces a new resource to be created.|||False|
|network_profile|network_policy| Sets up network policy to be used with Azure CNI. [Network policy allows us to control the traffic flow between pods](https://docs.microsoft.com/en-us/azure/aks/use-network-policies). Currently supported values are `calico` and `azure`. Changing this forces a new resource to be created.|||False|
|network_profile|dns_service_ip| IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created.|||False|
|network_profile|docker_bridge_cidr| IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created.|||False|
|network_profile|outbound_type| The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are `loadBalancer`, `userDefinedRouting`, `managedNATGateway` and `userAssignedNATGateway`. Defaults to `loadBalancer`.|||False|
|network_profile|pod_cidr| The CIDR to use for pod IP addresses. This field can only be set when `network_plugin` is set to `kubenet`. Changing this forces a new resource to be created.|||False|
|network_profile|service_cidr| The Network Range used by the Kubernetes service. Changing this forces a new resource to be created.|||False|
|network_profile|load_balancer_sku| Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are `Basic` and `Standard`. Defaults to `Standard`.|||False|
|network_profile|load_balancer_profile| A `load_balancer_profile` block. This can only be specified when `load_balancer_sku` is set to `Standard`.|||False|
|load_balancer_profile|outbound_ports_allocated| Number of desired SNAT port for each VM in the clusters load balancer. Must be between `0` and `64000` inclusive. Defaults to `0`.|||False|
|load_balancer_profile|idle_timeout_in_minutes| Desired outbound flow idle timeout in minutes for the cluster load balancer. Must be between `4` and `120` inclusive. Defaults to `30`.|||False|
|load_balancer_profile|managed_outbound_ip_count| Count of desired managed outbound IPs for the cluster load balancer. Must be between `1` and `100` inclusive.|||False|
|load_balancer_profile|outbound_ip_prefix_ids| The ID of the outbound Public IP Address Prefixes which should be used for the cluster load balancer.|||False|
|load_balancer_profile|outbound_ip_address_ids| The ID of the Public IP Addresses which should be used for outbound communication for the cluster load balancer.|||False|
|network_profile|nat_gateway_profile| A `nat_gateway_profile` block. This can only be specified when `load_balancer_sku` is set to `Standard` and `outbound_type` is set to `managedNATGateway` or `userAssignedNATGateway`.|||False|
|nat_gateway_profile|idle_timeout_in_minutes| Desired outbound flow idle timeout in minutes for the cluster load balancer. Must be between `4` and `120` inclusive. Defaults to `4`.|||False|
|nat_gateway_profile|managed_outbound_ip_count| Count of desired managed outbound IPs for the cluster load balancer. Must be between `1` and `100` inclusive.|||False|
|private_dns_zone| key | Key for  private_dns_zone||| Required if  |
|private_dns_zone| lz_key |Landing Zone Key in wich the private_dns_zone is located|||False|
|private_dns_zone| id | The id of the private_dns_zone |||False|
|role_based_access_control|azure_active_directory| An `azure_active_directory` block.|||False|
|azure_active_directory|managed| Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration.|||False|
|azure_active_directory|tenant_id| The Tenant ID used for Azure Active Directory Application. If this isn't specified the Tenant ID of the current Subscription is used.|||False|
|azure_active_directory|admin_group_object_ids| A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster.|||False|
|azure_active_directory|azure_rbac_enabled| Is Role Based Access Control based on Azure AD enabled?|||False|
|azure_active_directory|client_app_id| The Client ID of an Azure Active Directory Application.|||True|
|azure_active_directory|server_app_id| The Server ID of an Azure Active Directory Application.|||True|
|azure_active_directory|server_app_secret| The Server Secret of an Azure Active Directory Application.|||True|
|role_based_access_control|enabled| Is Role Based Access Control Enabled? Changing this forces a new resource to be created.|||True|
|service_principal|client_id| The Client ID for the Service Principal.|||True|
|service_principal|client_secret| The Client Secret for the Service Principal.|||True|
|windows_profile|admin_username| The Admin Username for Windows VMs.|||True|
|windows_profile|admin_password| The Admin Password for Windows VMs. Length must be between 14 and 123 characters.|||True|
|windows_profile|license| Specifies the type of on-premise license which should be used for Node Pool Windows Virtual Machine. At this time the only possible value is `Windows_Server`.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The Kubernetes Managed Cluster ID.|||
|fqdn|The FQDN of the Azure Kubernetes Managed Cluster.|||
|private_fqdn|The FQDN for the Kubernetes Cluster when private link has been enabled, which is only resolvable inside the Virtual Network used by the Kubernetes Cluster.|||
|portal_fqdn|The FQDN for the Azure Portal resources when private link has been enabled, which is only resolvable inside the Virtual Network used by the Kubernetes Cluster.|||
|kube_admin_config|A `kube_admin_config` block as defined below. This is only available when Role Based Access Control with Azure Active Directory is enabled.|||
|kube_admin_config_raw|Raw Kubernetes config for the admin account to be used by [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) and other compatible tools. This is only available when Role Based Access Control with Azure Active Directory is enabled.|||
|kube_config|A `kube_config` block as defined below.|||
|kube_config_raw|Raw Kubernetes config to be used by [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) and other compatible tools.|||
|http_application_routing|A `http_application_routing` block as defined below.|||
|node_resource_group|The auto-generated Resource Group which contains the resources for this Managed Kubernetes Cluster. |||
|addon_profile|An `addon_profile` block as defined below.|||



module "kubernetes_cluster_node_pool" {
  source   = "./modules/aaa/kubernetes_cluster_node_pool"
  for_each = local.aaa.kubernetes_cluster_node_pool

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

    kubernetes_cluster_id = coalesce(
        try(local.combined_objects_kubernetes_cluster[each.value.kubernetes_cluster.lz_key][each.value.kubernetes_cluster.key].id, null),
        try(local.combined_objects_kubernetes_cluster[local.client_config.landingzone_key][each.value.kubernetes_cluster.key].id, null),
        try(each.value.kubernetes_cluster.id, null)
    )

    proximity_placement_group_id = coalesce(
        try(local.combined_objects_proximity_placement_groups[each.value.proximity_placement_group.lz_key][each.value.proximity_placement_group.key].id, null),
        try(local.combined_objects_proximity_placement_groups[local.client_config.landingzone_key][each.value.proximity_placement_group.key].id, null),
        try(each.value.proximity_placement_group.id, null)
    )


  remote_objects = {
        kubernetes_cluster = local.combined_objects_kubernetes_cluster
        proximity_placement_group = local.combined_objects_proximity_placement_groups
  }
}
output "kubernetes_cluster_node_pool" {
  value = module.kubernetes_cluster_node_pool
}