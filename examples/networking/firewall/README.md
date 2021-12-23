module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# firewall

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Firewall. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|sku_name| Sku name of the Firewall. Possible values are `AZFW_Hub` and `AZFW_VNet`.  Changing this forces a new resource to be created.||False|
|sku_tier| Sku tier of the Firewall. Possible values are `Premium` and `Standard`.  Changing this forces a new resource to be created.||False|
|firewall_policy|The `firewall_policy` block as defined below.|Block|False|
|ip_configuration| An `ip_configuration` block as documented below.| Block |False|
|dns_servers| A list of DNS servers that the Azure Firewall will direct DNS traffic to the for name resolution.||False|
|private_ip_ranges| A list of SNAT private CIDR IP ranges, or the special string `IANAPrivateRanges`, which indicates Azure Firewall does not SNAT when the destination IP address is a private range per IANA RFC 1918.||False|
|management_ip_configuration| A `management_ip_configuration` block as documented below, which allows force-tunnelling of traffic to be performed by the firewall. Adding or removing this block or changing the `subnet_id` in an existing block forces a new resource to be created.| Block |False|
|threat_intel_mode| The operation mode for threat intelligence-based filtering. Possible values are: `Off`, `Alert`,`Deny` and `""`(empty string). Defaults to `Alert`.||False|
|virtual_hub| A `virtual_hub` block as documented below.| Block |False|
|zones| Specifies the availability zones in which the Azure Firewall should be created. Changing this forces a new resource to be created.||False|
|tags| A mapping of tags to assign to the resource.||False|
|name| Specifies the name of the Firewall. Changing this forces a new resource to be created.||True|
|subnet|The `subnet` block as defined below.|Block|False|
|public_ip_address_id| The ID of the Public IP Address associated with the firewall.||True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|firewall_policy| key | Key for  firewall_policy||| Required if  |
|firewall_policy| lz_key |Landing Zone Key in wich the firewall_policy is located|||False|
|firewall_policy| id | The id of the firewall_policy |||False|
|ip_configuration|name| Specifies the name of the IP Configuration.|||True|
|ip_configuration|subnet_id| Reference to the subnet associated with the IP Configuration.|||False|
|ip_configuration|public_ip_address_id| The ID of the Public IP Address associated with the firewall.|||True|
|management_ip_configuration|name| Specifies the name of the IP Configuration.|||True|
|management_ip_configuration|subnet_id| Reference to the subnet associated with the IP Configuration. Changing this forces a new resource to be created.|||True|
|management_ip_configuration|public_ip_address_id| The ID of the Public IP Address associated with the firewall.|||True|
|virtual_hub|virtual_hub_id| Specifies the ID of the Virtual Hub where the Firewall resides in.|||True|
|virtual_hub|public_ip_count| Specifies the number of public IPs to assign to the Firewall. Defaults to `1`.|||False|
|subnet| key | Key for  subnet||| Required if  |
|subnet| lz_key |Landing Zone Key in wich the subnet is located|||False|
|subnet| id | The id of the subnet |||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Azure Firewall.|||
|ip_configuration|A `ip_configuration` block as defined below.|||
|virtual_hub|A `virtual_hub` block as defined below.|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# firewall_application_rule_collection

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Application Rule Collection which must be unique within the Firewall. Changing this forces a new resource to be created.||True|
|azure_firewall_name| Specifies the name of the Firewall in which the Application Rule Collection should be created. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|priority| Specifies the priority of the rule collection. Possible values are between `100` - `65000`.||True|
|action| Specifies the action the rule will apply to matching traffic. Possible values are `Allow` and `Deny`.||True|
|rule| One or more `rule` blocks as defined below.| Block |True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|rule|name| Specifies the name of the rule.|||True|
|rule|description| Specifies a description for the rule.|||False|
|rule|source_addresses| A list of source IP addresses and/or IP ranges.|||False|
|rule|source_ip_groups| A list of source IP Group IDs for the rule.|||False|
|rule|fqdn_tags| A list of FQDN tags. Possible values are `AppServiceEnvironment`, `AzureBackup`, `AzureKubernetesService`, `HDInsight`, `MicrosoftActiveProtectionService`, `WindowsDiagnostics`, `WindowsUpdate` and `WindowsVirtualDesktop`.|||False|
|rule|target_fqdns| A list of FQDNs.|||False|
|rule|protocol| One or more `protocol` blocks as defined below.|||False|
|protocol|port| Specify a port for the connection.|||True|
|protocol|type| Specifies the type of connection. Possible values are `Http`, `Https` and `Mssql`.|||True|

## Outputs
| Name | Description |
|------|-------------|

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# firewall_nat_rule_collection

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the NAT Rule Collection which must be unique within the Firewall. Changing this forces a new resource to be created.||True|
|azure_firewall_name| Specifies the name of the Firewall in which the NAT Rule Collection should be created. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|priority| Specifies the priority of the rule collection. Possible values are between `100` - `65000`.||True|
|action| Specifies the action the rule will apply to matching traffic. Possible values are `Dnat` and `Snat`.||True|
|rule| One or more `rule` blocks as defined below.| Block |True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|rule|name| Specifies the name of the rule.|||True|
|rule|description| Specifies a description for the rule.|||False|
|rule|destination_addresses| A list of destination IP addresses and/or IP ranges.|||True|
|rule|destination_ports| A list of destination ports.|||True|
|rule|protocols| A list of protocols. Possible values are `Any`, `ICMP`, `TCP` and `UDP`.  If `action` is `Dnat`, protocols can only be `TCP` and `UDP`.|||True|
|rule|source_addresses| A list of source IP addresses and/or IP ranges.|||False|
|rule|source_ip_groups| A list of source IP Group IDs for the rule.|||False|
|rule|translated_address| The address of the service behind the Firewall.|||True|
|rule|translated_port| The port of the service behind the Firewall.|||True|

## Outputs
| Name | Description |
|------|-------------|


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# firewall_network_rule_collection

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Network Rule Collection which must be unique within the Firewall. Changing this forces a new resource to be created.||True|
|azure_firewall_name| Specifies the name of the Firewall in which the Network Rule Collection should be created. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|priority| Specifies the priority of the rule collection. Possible values are between `100` - `65000`.||True|
|action| Specifies the action the rule will apply to matching traffic. Possible values are `Allow` and `Deny`.||True|
|rule| One or more `rule` blocks as defined below.| Block |True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|rule|name| Specifies the name of the rule.|||True|
|rule|description| Specifies a description for the rule.|||False|
|rule|source_addresses| A list of source IP addresses and/or IP ranges.|||True|
|rule|source_ip_groups| A list of IP Group IDs for the rule.|||False|
|rule|destination_addresses| Either a list of destination IP addresses and/or IP ranges, or a list of destination [Service Tags](https://docs.microsoft.com/en-us/azure/virtual-network/service-tags-overview#available-service-tags).|||False|
|rule|destination_ip_groups| A list of destination IP Group IDs for the rule.|||False|
|rule|destination_fqdns| A list of destination FQDNS for the rule.|||False|
|rule|destination_ports| A list of destination ports.|||True|
|rule|protocols| A list of protocols. Possible values are `Any`, `ICMP`, `TCP` and `UDP`.|||True|

## Outputs
| Name | Description |
|------|-------------|


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# firewall_policy

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| region |The region_key where the resource will be deployed|String|True|
|name| The name which should be used for this Firewall Policy. Changing this forces a new Firewall Policy to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|base_policy_id| The ID of the base Firewall Policy.||False|
|dns| A `dns` block as defined below.| Block |False|
|identity| An `identity` block as defined below. Changing this forces a new Firewall Policy to be created.| Block |False|
|insights| An `insights` block as defined below.| Block |False|
|intrusion_detection| A `intrusion_detection` block as defined below.| Block |False|
|private_ip_ranges| A list of private IP ranges to which traffic will not be SNAT.||False|
|sku| The SKU Tier of the Firewall Policy. Possible values are `Standard`, `Premium`. Changing this forces a new Firewall Policy to be created.||False|
|tags| A mapping of tags which should be assigned to the Firewall Policy.||False|
|threat_intelligence_allowlist| A `threat_intelligence_allowlist` block as defined below.| Block |False|
|threat_intelligence_mode| The operation mode for Threat Intelligence. Possible values are `Alert`, `Deny` and `Off`. Defaults to `Alert`.||False|
|tls_certificate| A `tls_certificate` block as defined below.| Block |False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|dns|network_rule_fqdn_enabled| Should the network rule fqdn be enabled?|||False|
|dns|proxy_enabled| Whether to enable DNS proxy on Firewalls attached to this Firewall Policy? Defaults to `false`.|||False|
|dns|servers| A list of custom DNS servers' IP addresses.|||False|
|identity|type| Type of the identity. At the moment only "UserAssigned" is supported. Changing this forces a new Firewall Policy to be created.|||True|
|identity|user_assigned_identity_ids| Specifies a list of user assigned managed identities.|||False|
|insights|enabled| Whether the insights functionality is enabled for this Firewall Policy.|||True|
|insights|default_log_analytics_workspace_id| The ID of the default Log Analytics Workspace that the Firewalls associated with this Firewall Policy will send their logs to, when there is no location matches in the `log_analytics_workspace`.|||True|
|insights|retention_in_days| The log retention period in days. |||False|
|insights|log_analytics_workspace| A list of `log_analytics_workspace` block as defined below.|||False|
|intrusion_detection|mode| In which mode you want to run intrusion detection: "Off", "Alert" or "Deny".|||False|
|intrusion_detection|signature_overrides| One or more `signature_overrides` blocks as defined below.|||False|
|signature_overrides|id| 12-digit number (id) which identifies your signature.|||False|
|signature_overrides|state| state can be any of "Off", "Alert" or "Deny".|||False|
|intrusion_detection|traffic_bypass| One or more `traffic_bypass` blocks as defined below.|||False|
|traffic_bypass|name| The name which should be used for this bypass traffic setting.|||True|
|traffic_bypass|protocol| The protocols any of "ANY", "TCP", "ICMP", "UDP" that shall be bypassed by intrusion detection.|||True|
|traffic_bypass|description| The description for this bypass traffic setting.|||False|
|traffic_bypass|destination_addresses| Specifies a list of destination IP addresses that shall be bypassed by intrusion detection.|||False|
|traffic_bypass|destination_ip_groups| Specifies a list of destination IP groups that shall be bypassed by intrusion detection.|||False|
|traffic_bypass|destination_ports| Specifies a list of destination IP ports that shall be bypassed by intrusion detection.|||False|
|traffic_bypass|source_addresses| Specifies a list of source addresses that shall be bypassed by intrusion detection.|||False|
|traffic_bypass|source_ip_groups| Specifies a list of source ip groups that shall be bypassed by intrusion detection.|||False|
|threat_intelligence_allowlist|fqdns| A list of FQDNs that will be skipped for threat detection.|||False|
|threat_intelligence_allowlist|ip_addresses| A list of IP addresses or CIDR ranges that will be skipped for threat detection.|||False|
|tls_certificate|key_vault_secret_id| The ID of the Key Vault, where the secret or certificate is stored.|||True|
|tls_certificate|name| The name of the certificate.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Firewall Policy.|||
|child_policies|A list of reference to child Firewall Policies of this Firewall Policy.|||
|firewalls|A list of references to Azure Firewalls that this Firewall Policy is associated with.|||
|rule_collection_groups|A list of references to Firewall Policy Rule Collection Groups that belongs to this Firewall Policy.|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# firewall_policy_rule_collection_group

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name which should be used for this Firewall Policy Rule Collection Group. Changing this forces a new Firewall Policy Rule Collection Group to be created.||True|
|firewall_policy|The `firewall_policy` block as defined below.|Block|True|
|priority| The priority of the Firewall Policy Rule Collection Group. The range is 100-65000.||True|
|application_rule_collection| One or more `application_rule_collection` blocks as defined below.| Block |False|
|nat_rule_collection| One or more `nat_rule_collection` blocks as defined below.| Block |False|
|network_rule_collection| One or more `network_rule_collection` blocks as defined below.| Block |False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|firewall_policy| key | Key for  firewall_policy||| Required if  |
|firewall_policy| lz_key |Landing Zone Key in wich the firewall_policy is located|||True|
|firewall_policy| id | The id of the firewall_policy |||True|
|application_rule_collection|name| The name which should be used for this application rule collection.|||True|
|application_rule_collection|action| The action to take for the application rules in this collection. Possible values are `Allow` and `Deny`.|||True|
|application_rule_collection|priority| The priority of the application rule collection. The range is `100` - `65000`.|||True|
|application_rule_collection|rule| One or more `rule` (application rule) blocks as defined below.|||True|
|nat_rule_collection|name| The name which should be used for this nat rule collection.|||True|
|nat_rule_collection|action| The action to take for the nat rules in this collection. Currently, the only possible value is `Dnat`.|||True|
|nat_rule_collection|priority| The priority of the nat rule collection. The range is `100` - `65000`.|||True|
|nat_rule_collection|rule| A `rule` (nat rule) block as defined above.|||True|
|network_rule_collection|name| The name which should be used for this network rule collection.|||True|
|network_rule_collection|action| The action to take for the network rules in this collection. Possible values are `Allow` and `Deny`.|||True|
|network_rule_collection|priority| The priority of the network rule collection. The range is `100` - `65000`.|||True|
|network_rule_collection|rule| One or more `rule` (network rule) blocks as defined above.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Firewall Policy Rule Collection Group.|||

