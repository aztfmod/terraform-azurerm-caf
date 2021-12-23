module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# application_gateway

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the Application Gateway. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|backend_address_pool| One or more `backend_address_pool` blocks as defined below.| Block |True|
|backend_http_settings| One or more `backend_http_settings` blocks as defined below.| Block |True|
|frontend_ip_configuration| One or more `frontend_ip_configuration` blocks as defined below.| Block |True|
|frontend_port| One or more `frontend_port` blocks as defined below.| Block |True|
|gateway_ip_configuration| One or more `gateway_ip_configuration` blocks as defined below.| Block |True|
|http_listener| One or more `http_listener` blocks as defined below.| Block |True|
|identity| An `identity` block as defined below.| Block |False|
|private_link_configuration| One or more `private_link_configuration` blocks as defined below.| Block |False|
|request_routing_rule| One or more `request_routing_rule` blocks as defined below.| Block |True|
|sku| A `sku` block as defined below.| Block |True|
|zones| A collection of availability zones to spread the Application Gateway over.||False|
|trusted_client_certificate| One or more `trusted_client_certificate` blocks as defined below.| Block |False|
|ssl_profile| One or more `ssl_profile` blocks as defined below.| Block |False|
|authentication_certificate| One or more `authentication_certificate` blocks as defined below.| Block |False|
|trusted_root_certificate| One or more `trusted_root_certificate` blocks as defined below.| Block |False|
|ssl_policy| a `ssl policy` block as defined below.| Block |False|
|enable_http2| Is HTTP2 enabled on the application gateway resource? Defaults to `false`.||False|
|force_firewall_policy_association| Is the Firewall Policy associated with the Application Gateway?||False|
|probe| One or more `probe` blocks as defined below.||False|
|ssl_certificate| One or more `ssl_certificate` blocks as defined below.| Block |False|
|tags| A mapping of tags to assign to the resource.||False|
|url_path_map| One or more `url_path_map` blocks as defined below.| Block |False|
|waf_configuration| A `waf_configuration` block as defined below.| Block |False|
|custom_error_configuration| One or more `custom_error_configuration` blocks as defined below.| Block |False|
|firewall_policy|The `firewall_policy` block as defined below.|Block|False|
|redirect_configuration| One or more `redirect_configuration` blocks as defined below.| Block |False|
|autoscale_configuration| A `autoscale_configuration` block as defined below.| Block |False|
|rewrite_rule_set| One or more `rewrite_rule_set` blocks as defined below. Only valid for v2 SKUs.| Block |False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|backend_address_pool|name| The name of the Backend Address Pool.|||True|
|backend_address_pool|fqdns| A list of FQDN's which should be part of the Backend Address Pool.|||False|
|backend_address_pool|ip_addresses| A list of IP Addresses which should be part of the Backend Address Pool.|||False|
|backend_http_settings|cookie_based_affinity| Is Cookie-Based Affinity enabled? Possible values are `Enabled` and `Disabled`.|||True|
|backend_http_settings|affinity_cookie_name| The name of the affinity cookie.|||False|
|backend_http_settings|name| The name of the Backend HTTP Settings Collection.|||True|
|backend_http_settings|path| The Path which should be used as a prefix for all HTTP requests.|||False|
|backend_http_settings|probe_name| The name of an associated HTTP Probe.|||False|
|backend_http_settings|protocol`- (Required) The Protocol which should be used. Possible values are `Http||||False|
|backend_http_settings|request_timeout| The request timeout in seconds, which must be between 1 and 86400 seconds.|||True|
|backend_http_settings|host_name| Host header to be sent to the backend servers. Cannot be set if `pick_host_name_from_backend_address` is set to `true`.|||False|
|backend_http_settings|pick_host_name_from_backend_address| Whether host header should be picked from the host name of the backend server. Defaults to `false`.|||False|
|backend_http_settings|authentication_certificate| One or more `authentication_certificate` blocks.|||False|
|authentication_certificate|name| The Name of the Authentication Certificate to use.|||True|
|authentication_certificate|data| The contents of the Authentication Certificate which should be used.|||True|
|backend_http_settings|trusted_root_certificate_names| A list of `trusted_root_certificate` names.|||False|
|backend_http_settings|connection_draining| A `connection_draining` block as defined below.|||False|
|connection_draining|enabled| If connection draining is enabled or not.|||True|
|connection_draining|drain_timeout_sec| The number of seconds connection draining is active. Acceptable values are from `1` second to `3600` seconds.|||True|
|frontend_ip_configuration|name| The name of the Frontend IP Configuration.|||True|
|frontend_ip_configuration|subnet_id| The ID of the Subnet.|||False|
|frontend_ip_configuration|private_ip_address| The Private IP Address to use for the Application Gateway.|||False|
|frontend_ip_configuration|public_ip_address_id| The ID of a Public IP Address which the Application Gateway should use. The allocation method for the Public IP Address depends on the `sku` of this Application Gateway. Please refer to the [Azure documentation for public IP addresses](https://docs.microsoft.com/en-us/azure/virtual-network/public-ip-addresses#application-gateways) for details.|||False|
|frontend_ip_configuration|private_ip_address_allocation| The Allocation Method for the Private IP Address. Possible values are `Dynamic` and `Static`.|||False|
|frontend_ip_configuration|private_link_configuration_name| The name of the private link configuration to use for this frontend IP configuration.|||False|
|frontend_port|name| The name of the Frontend Port.|||True|
|frontend_port|port| The port used for this Frontend Port.|||True|
|gateway_ip_configuration|name| The Name of this Gateway IP Configuration.|||True|
|gateway_ip_configuration|subnet_id| The ID of the Subnet which the Application Gateway should be connected to.|||True|
|http_listener|name| The Name of the HTTP Listener.|||True|
|http_listener|frontend_ip_configuration_name| The Name of the Frontend IP Configuration used for this HTTP Listener.|||True|
|http_listener|frontend_port_name| The Name of the Frontend Port use for this HTTP Listener.|||True|
|http_listener|host_name| The Hostname which should be used for this HTTP Listener. Setting this value changes Listener Type to 'Multi site'.|||False|
|http_listener|host_names| A list of Hostname(s) should be used for this HTTP Listener. It allows special wildcard characters.|||False|
|http_listener|protocol| The Protocol to use for this HTTP Listener. Possible values are `Http` and `Https`.|||True|
|http_listener|require_sni| Should Server Name Indication be Required? Defaults to `false`.|||False|
|http_listener|ssl_certificate_name| The name of the associated SSL Certificate which should be used for this HTTP Listener.|||False|
|http_listener|custom_error_configuration| One or more `custom_error_configuration` blocks as defined below.|||False|
|custom_error_configuration|status_code| Status code of the application gateway customer error. Possible values are `HttpStatus403` and `HttpStatus502`|||True|
|custom_error_configuration|custom_error_page_url| Error page URL of the application gateway customer error.|||True|
|http_listener|firewall_policy_id| The ID of the Web Application Firewall Policy which should be used for this HTTP Listener.|||False|
|http_listener|ssl_profile_name| The name of the associated SSL Profile which should be used for this HTTP Listener.|||False|
|identity|type| The Managed Service Identity Type of this Application Gateway. The only possible value is `UserAssigned`. Defaults to `UserAssigned`.|||False|
|identity|identity_ids| Specifies a list with a single user managed identity id to be assigned to the Application Gateway.|||True|
|private_link_configuration|name| The name of the private link configuration.|||True|
|private_link_configuration|ip_configuration| One or more `ip_configuration` blocks as defined below.|||True|
|ip_configuration|name| The name of the IP configuration.|||True|
|ip_configuration|subnet_id| The ID of the subnet the private link configuration should connect to.|||True|
|ip_configuration|private_ip_address_allocation| The allocation method used for the Private IP Address. Possible values are `Dynamic` and `Static`.|||True|
|ip_configuration|primary| Is this the Primary IP Configuration?|||True|
|ip_configuration|private_ip_address| The Static IP Address which should be used.|||False|
|request_routing_rule|name| The Name of this Request Routing Rule.|||True|
|request_routing_rule|rule_type| The Type of Routing that should be used for this Rule. Possible values are `Basic` and `PathBasedRouting`.|||True|
|request_routing_rule|http_listener_name| The Name of the HTTP Listener which should be used for this Routing Rule.|||True|
|request_routing_rule|backend_address_pool_name| The Name of the Backend Address Pool which should be used for this Routing Rule. Cannot be set if `redirect_configuration_name` is set.|||False|
|request_routing_rule|backend_http_settings_name| The Name of the Backend HTTP Settings Collection which should be used for this Routing Rule. Cannot be set if `redirect_configuration_name` is set.|||False|
|request_routing_rule|redirect_configuration_name| The Name of the Redirect Configuration which should be used for this Routing Rule. Cannot be set if either `backend_address_pool_name` or `backend_http_settings_name` is set.|||False|
|request_routing_rule|rewrite_rule_set_name| The Name of the Rewrite Rule Set which should be used for this Routing Rule. Only valid for v2 SKUs.|||False|
|request_routing_rule|backend_address_pool_name`, `backend_http_settings_name`, `redirect_configuration_name`, and `rewrite_rule_set_name||||False|
|request_routing_rule|url_path_map_name| The Name of the URL Path Map which should be associated with this Routing Rule.|||False|
|request_routing_rule|priority| Rule evaluation order can be dictated by specifying an integer value from `1` to `20000` with `1` being the highest priority and `20000` being the lowest priority.|||False|
|sku|name| The Name of the SKU to use for this Application Gateway. Possible values are `Standard_Small`, `Standard_Medium`, `Standard_Large`, `Standard_v2`, `WAF_Medium`, `WAF_Large`, and `WAF_v2`.|||True|
|sku|tier| The Tier of the SKU to use for this Application Gateway. Possible values are `Standard`, `Standard_v2`, `WAF` and `WAF_v2`.|||True|
|sku|capacity| The Capacity of the SKU to use for this Application Gateway. When using a V1 SKU this value must be between 1 and 32, and 1 to 125 for a V2 SKU. This property is optional if `autoscale_configuration` is set.|||True|
|trusted_client_certificate|name| The name of the Trusted Client Certificate that is unique within this Application Gateway.|||True|
|trusted_client_certificate|data| The base-64 encoded certificate.|||True|
|ssl_profile|name| The name of the SSL Profile that is unique within this Application Gateway.|||True|
|ssl_profile|trusted_client_certificate_names| The name of the Trusted Client Certificate that will be used to authenticate requests from clients.|||False|
|ssl_profile|verify_client_cert_issuer_dn| Should client certificate issuer DN be verified?  Defaults to `false`.|||False|
|ssl_profile|ssl_policy| a `ssl policy` block as defined below.|||False|
|ssl_policy|disabled_protocols| A list of SSL Protocols which should be disabled on this Application Gateway. Possible values are `TLSv1_0`, `TLSv1_1` and `TLSv1_2`.|||False|
|ssl_policy|disabled_protocols| A list of SSL Protocols which should be disabled on this Application Gateway. Possible values are `TLSv1_0`, `TLSv1_1` and `TLSv1_2`.|||False|
|ssl_policy|policy_type| The Type of the Policy. Possible values are `Predefined` and `Custom`.|||False|
|ssl_policy|policy_type| The Type of the Policy. Possible values are `Predefined` and `Custom`.|||False|
|ssl_policy|policy_name| The Name of the Policy e.g AppGwSslPolicy20170401S. Required if `policy_type` is set to `Predefined`. Possible values can change over time and|||False|
|ssl_policy|cipher_suites| A List of accepted cipher suites. Possible values are: `TLS_DHE_DSS_WITH_AES_128_CBC_SHA`, `TLS_DHE_DSS_WITH_AES_128_CBC_SHA256`, `TLS_DHE_DSS_WITH_AES_256_CBC_SHA`, `TLS_DHE_DSS_WITH_AES_256_CBC_SHA256`, `TLS_DHE_RSA_WITH_AES_128_CBC_SHA`, `TLS_DHE_RSA_WITH_AES_128_GCM_SHA256`, `TLS_DHE_RSA_WITH_AES_256_CBC_SHA`, `TLS_DHE_RSA_WITH_AES_256_GCM_SHA384`, `TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA`, `TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256`, `TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256`, `TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA`, `TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384`, `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384`, `TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA`, `TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256`, `TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA`, `TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384`, `TLS_RSA_WITH_3DES_EDE_CBC_SHA`, `TLS_RSA_WITH_AES_128_CBC_SHA`, `TLS_RSA_WITH_AES_128_CBC_SHA256`, `TLS_RSA_WITH_AES_128_GCM_SHA256`, `TLS_RSA_WITH_AES_256_CBC_SHA`, `TLS_RSA_WITH_AES_256_CBC_SHA256` and `TLS_RSA_WITH_AES_256_GCM_SHA384`.|||False|
|ssl_policy|min_protocol_version| The minimal TLS version. Possible values are `TLSv1_0`, `TLSv1_1` and `TLSv1_2`.|||False|
|authentication_certificate|name| The Name of the Authentication Certificate to use.|||True|
|authentication_certificate|data| The contents of the Authentication Certificate which should be used.|||True|
|trusted_root_certificate|name| The Name of the Trusted Root Certificate to use.|||True|
|trusted_root_certificate|data| The contents of the Trusted Root Certificate which should be used. Required if `key_vault_secret_id` is not set.|||False|
|trusted_root_certificate|key_vault_secret_id| The Secret ID of (base-64 encoded unencrypted pfx) `Secret` or `Certificate` object stored in Azure KeyVault. You need to enable soft delete for the Key Vault to use this feature. Required if `data` is not set.|||False|
|ssl_policy|disabled_protocols| A list of SSL Protocols which should be disabled on this Application Gateway. Possible values are `TLSv1_0`, `TLSv1_1` and `TLSv1_2`.|||False|
|ssl_policy|disabled_protocols| A list of SSL Protocols which should be disabled on this Application Gateway. Possible values are `TLSv1_0`, `TLSv1_1` and `TLSv1_2`.|||False|
|ssl_policy|policy_type| The Type of the Policy. Possible values are `Predefined` and `Custom`.|||False|
|ssl_policy|policy_type| The Type of the Policy. Possible values are `Predefined` and `Custom`.|||False|
|ssl_policy|policy_name| The Name of the Policy e.g AppGwSslPolicy20170401S. Required if `policy_type` is set to `Predefined`. Possible values can change over time and|||False|
|ssl_policy|cipher_suites| A List of accepted cipher suites. Possible values are: `TLS_DHE_DSS_WITH_AES_128_CBC_SHA`, `TLS_DHE_DSS_WITH_AES_128_CBC_SHA256`, `TLS_DHE_DSS_WITH_AES_256_CBC_SHA`, `TLS_DHE_DSS_WITH_AES_256_CBC_SHA256`, `TLS_DHE_RSA_WITH_AES_128_CBC_SHA`, `TLS_DHE_RSA_WITH_AES_128_GCM_SHA256`, `TLS_DHE_RSA_WITH_AES_256_CBC_SHA`, `TLS_DHE_RSA_WITH_AES_256_GCM_SHA384`, `TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA`, `TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256`, `TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256`, `TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA`, `TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384`, `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384`, `TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA`, `TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256`, `TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA`, `TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384`, `TLS_RSA_WITH_3DES_EDE_CBC_SHA`, `TLS_RSA_WITH_AES_128_CBC_SHA`, `TLS_RSA_WITH_AES_128_CBC_SHA256`, `TLS_RSA_WITH_AES_128_GCM_SHA256`, `TLS_RSA_WITH_AES_256_CBC_SHA`, `TLS_RSA_WITH_AES_256_CBC_SHA256` and `TLS_RSA_WITH_AES_256_GCM_SHA384`.|||False|
|ssl_policy|min_protocol_version| The minimal TLS version. Possible values are `TLSv1_0`, `TLSv1_1` and `TLSv1_2`.|||False|
|ssl_certificate|name| The Name of the SSL certificate that is unique within this Application Gateway|||True|
|ssl_certificate|data| PFX certificate. Required if `key_vault_secret_id` is not set.|||False|
|ssl_certificate|password| Password for the pfx file specified in data.  Required if `data` is set.|||False|
|ssl_certificate|key_vault_secret_id| Secret Id of (base-64 encoded unencrypted pfx) `Secret` or `Certificate` object stored in Azure KeyVault. You need to enable soft delete for keyvault to use this feature. Required if `data` is not set.|||False|
|url_path_map|name| The Name of the URL Path Map.|||True|
|url_path_map|default_backend_address_pool_name| The Name of the Default Backend Address Pool which should be used for this URL Path Map. Cannot be set if `default_redirect_configuration_name` is set.|||False|
|url_path_map|default_backend_http_settings_name| The Name of the Default Backend HTTP Settings Collection which should be used for this URL Path Map. Cannot be set if `default_redirect_configuration_name` is set.|||False|
|url_path_map|default_redirect_configuration_name| The Name of the Default Redirect Configuration which should be used for this URL Path Map. Cannot be set if either `default_backend_address_pool_name` or `default_backend_http_settings_name` is set.|||False|
|url_path_map|default_rewrite_rule_set_name| The Name of the Default Rewrite Rule Set which should be used for this URL Path Map. Only valid for v2 SKUs.|||False|
|url_path_map|path_rule| One or more `path_rule` blocks as defined above.|||True|
|path_rule|name| The Name of the Path Rule.|||True|
|path_rule|paths| A list of Paths used in this Path Rule.|||True|
|path_rule|backend_address_pool_name| The Name of the Backend Address Pool to use for this Path Rule. Cannot be set if `redirect_configuration_name` is set.|||False|
|path_rule|backend_http_settings_name| The Name of the Backend HTTP Settings Collection to use for this Path Rule. Cannot be set if `redirect_configuration_name` is set.|||False|
|path_rule|redirect_configuration_name| The Name of a Redirect Configuration to use for this Path Rule. Cannot be set if `backend_address_pool_name` or `backend_http_settings_name` is set.|||False|
|path_rule|rewrite_rule_set_name| The Name of the Rewrite Rule Set which should be used for this URL Path Map. Only valid for v2 SKUs.|||False|
|path_rule|firewall_policy_id| The ID of the Web Application Firewall Policy which should be used as a HTTP Listener.|||False|
|waf_configuration|enabled| Is the Web Application Firewall be enabled?|||True|
|waf_configuration|firewall_mode| The Web Application Firewall Mode. Possible values are `Detection` and `Prevention`.|||True|
|waf_configuration|rule_set_type| The Type of the Rule Set used for this Web Application Firewall. Currently, only `OWASP` is supported.|||True|
|waf_configuration|rule_set_version| The Version of the Rule Set used for this Web Application Firewall. Possible values are `2.2.9`, `3.0`, and `3.1`.|||True|
|waf_configuration|disabled_rule_group| one or more `disabled_rule_group` blocks as defined below.|||False|
|disabled_rule_group|rule_group_name| The rule group where specific rules should be disabled. Accepted values are:  `crs_20_protocol_violations`, `crs_21_protocol_anomalies`, `crs_23_request_limits`, `crs_30_http_policy`, `crs_35_bad_robots`, `crs_40_generic_attacks`, `crs_41_sql_injection_attacks`, `crs_41_xss_attacks`, `crs_42_tight_security`, `crs_45_trojans`, `General`, `REQUEST-911-METHOD-ENFORCEMENT`, `REQUEST-913-SCANNER-DETECTION`, `REQUEST-920-PROTOCOL-ENFORCEMENT`, `REQUEST-921-PROTOCOL-ATTACK`, `REQUEST-930-APPLICATION-ATTACK-LFI`, `REQUEST-931-APPLICATION-ATTACK-RFI`, `REQUEST-932-APPLICATION-ATTACK-RCE`, `REQUEST-933-APPLICATION-ATTACK-PHP`, `REQUEST-941-APPLICATION-ATTACK-XSS`, `REQUEST-942-APPLICATION-ATTACK-SQLI`, `REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION`|||True|
|disabled_rule_group|rules| A list of rules which should be disabled in that group. Disables all rules in the specified group if `rules` is not specified.|||False|
|waf_configuration|file_upload_limit_mb| The File Upload Limit in MB. Accepted values are in the range `1`MB to `750`MB for the `WAF_v2` SKU, and `1`MB to `500`MB for all other SKUs. Defaults to `100`MB.|||False|
|waf_configuration|request_body_check| Is Request Body Inspection enabled?  Defaults to `true`.|||False|
|waf_configuration|max_request_body_size_kb| The Maximum Request Body Size in KB.  Accepted values are in the range `1`KB to `128`KB.  Defaults to `128`KB.|||False|
|waf_configuration|exclusion| one or more `exclusion` blocks as defined below.|||False|
|exclusion|match_variable| Match variable of the exclusion rule to exclude header, cookie or GET arguments. Possible values are `RequestHeaderNames`, `RequestArgNames` and `RequestCookieNames`|||True|
|exclusion|selector_match_operator| Operator which will be used to search in the variable content. Possible values are `Equals`, `StartsWith`, `EndsWith`, `Contains`. If empty will exclude all traffic on this `match_variable`|||False|
|exclusion|selector| String value which will be used for the filter operation. If empty will exclude all traffic on this `match_variable`|||False|
|custom_error_configuration|status_code| Status code of the application gateway customer error. Possible values are `HttpStatus403` and `HttpStatus502`|||True|
|custom_error_configuration|custom_error_page_url| Error page URL of the application gateway customer error.|||True|
|firewall_policy| key | Key for  firewall_policy||| Required if  |
|firewall_policy| lz_key |Landing Zone Key in wich the firewall_policy is located|||False|
|firewall_policy| id | The id of the firewall_policy |||False|
|redirect_configuration|name| Unique name of the redirect configuration block|||True|
|redirect_configuration|redirect_type| The type of redirect. Possible values are `Permanent`, `Temporary`, `Found` and `SeeOther`|||True|
|redirect_configuration|target_listener_name| The name of the listener to redirect to. Cannot be set if `target_url` is set.|||False|
|redirect_configuration|target_url| The Url to redirect the request to. Cannot be set if `target_listener_name` is set.|||False|
|redirect_configuration|include_path| Whether or not to include the path in the redirected Url. Defaults to `false`|||False|
|redirect_configuration|include_query_string| Whether or not to include the query string in the redirected Url. Default to `false`|||False|
|autoscale_configuration|min_capacity| Minimum capacity for autoscaling. Accepted values are in the range `0` to `100`.|||True|
|autoscale_configuration|max_capacity| Maximum capacity for autoscaling. Accepted values are in the range `2` to `125`.|||False|
|rewrite_rule_set|name| Unique name of the rewrite rule set block|||True|
|rewrite_rule_set|rewrite_rule| One or more `rewrite_rule` blocks as defined above.|||True|
|rewrite_rule|name| Unique name of the rewrite rule block|||True|
|rewrite_rule|rule_sequence| Rule sequence of the rewrite rule that determines the order of execution in a set.|||True|
|rewrite_rule|condition| One or more `condition` blocks as defined above.|||False|
|condition|variable| The [variable](https://docs.microsoft.com/en-us/azure/application-gateway/rewrite-http-headers#server-variables) of the condition.|||True|
|condition|pattern| The pattern, either fixed string or regular expression, that evaluates the truthfulness of the condition.|||True|
|condition|ignore_case| Perform a case in-sensitive comparison. Defaults to `false`|||False|
|condition|negate| Negate the result of the condition evaluation. Defaults to `false`|||False|
|rewrite_rule|request_header_configuration| One or more `request_header_configuration` blocks as defined above.|||False|
|request_header_configuration|header_name| Header name of the header configuration.|||True|
|request_header_configuration|header_value| Header value of the header configuration. To delete a request header set this property to an empty string.|||True|
|rewrite_rule|response_header_configuration| One or more `response_header_configuration` blocks as defined above.|||False|
|response_header_configuration|header_name| Header name of the header configuration.|||True|
|response_header_configuration|header_value| Header value of the header configuration. To delete a response header set this property to an empty string.|||True|
|rewrite_rule|url| One `url` block as defined above|||False|
|url|path| The URL path to rewrite.|||False|
|url|query_string| The query string to rewrite.|||False|
|url|reroute| Whether the URL path map should be reevaluated after this rewrite has been applied. [More info on rewrite configutation](https://docs.microsoft.com/en-us/azure/application-gateway/rewrite-http-headers-url#rewrite-configuration)|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Application Gateway.|||
|authentication_certificate|A list of `authentication_certificate` blocks as defined below.|||
|backend_address_pool|A list of `backend_address_pool` blocks as defined below.|||
|backend_http_settings|A list of `backend_http_settings` blocks as defined below.|||
|frontend_ip_configuration|A list of `frontend_ip_configuration` blocks as defined below.|||
|frontend_port|A list of `frontend_port` blocks as defined below.|||
|gateway_ip_configuration|A list of `gateway_ip_configuration` blocks as defined below.|||
|enable_http2| Is HTTP2 enabled on the application gateway resource? Defaults to `false`.|||
|http_listener|A list of `http_listener` blocks as defined below.|||
|private_endpoint_connection|A list of `private_endpoint_connection` blocks as defined below.|||
|private_link_configuration|A list of `private_link_configuration` blocks as defined below.|||
|probe|A `probe` block as defined below.|||
|request_routing_rule|A list of `request_routing_rule` blocks as defined below.|||
|ssl_certificate|A list of `ssl_certificate` blocks as defined below.|||
|url_path_map|A list of `url_path_map` blocks as defined below.|||
|custom_error_configuration|A list of `custom_error_configuration` blocks as defined below.|||
|redirect_configuration|A list of `redirect_configuration` blocks as defined below.|||
