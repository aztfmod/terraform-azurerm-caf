module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# frontdoor

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Front Door service. Must be globally unique. Changing this forces a new resource to be created.||True|
| region |The region_key where the resource will be deployed|String|False|
|resource_group|The `resource_group` block as defined below.|Block|True|
|backend_pool| A `backend_pool` block as defined below.| Block |True|
|backend_pool_health_probe| A `backend_pool_health_probe` block as defined below.| Block |True|
|backend_pool_load_balancing| A `backend_pool_load_balancing` block as defined below.| Block |True|
|backend_pools_send_receive_timeout_seconds| Specifies the send and receive timeout on forwarding request to the backend. When the timeout is reached, the request fails and returns. Possible values are between `0` - `240`. Defaults to `60`.||False|
|enforce_backend_pools_certificate_name_check| Enforce certificate name check on `HTTPS` requests to all backend pools, this setting will have no effect on `HTTP` requests. Permitted values are `true` or `false`.||True|
|backend_pools_send_receive_timeout_seconds| Specifies the send and receive timeout on forwarding request to the backend. When the timeout is reached, the request fails and returns. Possible values are between `0` - `240`. Defaults to `60`.||False|
|load_balancer_enabled| Should the Front Door Load Balancer be Enabled? Defaults to `true`.||False|
|friendly_name| A friendly name for the Front Door service.||False|
|frontend_endpoint| A `frontend_endpoint` block as defined below.| Block |True|
|routing_rule| A `routing_rule` block as defined below.| Block |True|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|backend_pool|name| Specifies the name of the Backend Pool.|||True|
|backend_pool|backend| A `backend` block as defined below.|||True|
|backend|enabled| Specifies if the backend is enabled or not. Valid options are `true` or `false`. Defaults to `true`.|||False|
|backend|address| Location of the backend (IP address or FQDN)|||True|
|backend|host_header| The value to use as the host header sent to the backend.|||True|
|backend|http_port| The HTTP TCP port number. Possible values are between `1` - `65535`.|||True|
|backend|https_port| The HTTPS TCP port number. Possible values are between `1` - `65535`.|||True|
|backend|priority| Priority to use for load balancing. Higher priorities will not be used for load balancing if any lower priority backend is healthy. Defaults to `1`.|||False|
|backend|weight| Weight of this endpoint for load balancing purposes. Defaults to `50`.|||False|
|backend_pool|load_balancing_name| Specifies the name of the `backend_pool_load_balancing` block within this resource to use for this `Backend Pool`.|||True|
|backend_pool|health_probe_name| Specifies the name of the `backend_pool_health_probe` block within this resource to use for this `Backend Pool`.|||True|
|backend_pool_health_probe|name| Specifies the name of the Health Probe.|||True|
|backend_pool_health_probe|enabled| Is this health probe enabled? Dafaults to `true`.|||False|
|backend_pool_health_probe|path| The path to use for the Health Probe. Default is `/`.|||False|
|backend_pool_health_probe|protocol| Protocol scheme to use for the Health Probe. Defaults to `Http`.|||False|
|backend_pool_health_probe|probe_method| Specifies HTTP method the health probe uses when querying the backend pool instances. Possible values include: `Get` and `Head`. Defaults to `Get`.|||False|
|backend_pool_health_probe|interval_in_seconds| The number of seconds between each Health Probe. Defaults to `120`.|||False|
|backend_pool_load_balancing|name| Specifies the name of the Load Balancer.|||True|
|backend_pool_load_balancing|sample_size| The number of samples to consider for load balancing decisions. Defaults to `4`.|||False|
|backend_pool_load_balancing|successful_samples_required| The number of samples within the sample period that must succeed. Defaults to `2`.|||False|
|backend_pool_load_balancing|additional_latency_milliseconds| The additional latency in milliseconds for probes to fall into the lowest latency bucket. Defaults to `0`.|||False|
|frontend_endpoint|name| Specifies the name of the `frontend_endpoint`.|||True|
|frontend_endpoint|host_name| Specifies the host name of the `frontend_endpoint`. Must be a domain name. In order to use a name.azurefd.net domain, the name value must match the Front Door name.|||True|
|frontend_endpoint|session_affinity_enabled| Whether to allow session affinity on this host. Valid options are `true` or `false` Defaults to `false`.|||False|
|frontend_endpoint|session_affinity_ttl_seconds| The TTL to use in seconds for session affinity, if applicable. Defaults to `0`.|||False|
|frontend_endpoint|web_application_firewall_policy_link_id| Defines the Web Application Firewall policy `ID` for each host.|||False|
|routing_rule|name| Specifies the name of the Routing Rule.|||True|
|routing_rule|frontend_endpoints| The names of the `frontend_endpoint` blocks within this resource to associate with this `routing_rule`.|||True|
|routing_rule|accepted_protocols| Protocol schemes to match for the Backend Routing Rule. Defaults to `Http`.|||False|
|routing_rule|patterns_to_match| The route patterns for the Backend Routing Rule. Defaults to `/*`.|||False|
|routing_rule|enabled| `Enable` or `Disable` use of this Backend Routing Rule. Permitted values are `true` or `false`. Defaults to `true`.|||False|
|routing_rule|forwarding_configuration| A `forwarding_configuration` block as defined below.|||False|
|forwarding_configuration|backend_pool_name| Specifies the name of the Backend Pool to forward the incoming traffic to.|||True|
|forwarding_configuration|cache_enabled| Specifies whether to Enable caching or not. Valid options are `true` or `false`. Defaults to `false`.|||False|
|forwarding_configuration|cache_use_dynamic_compression| Whether to use dynamic compression when caching. Valid options are `true` or `false`. Defaults to `false`.|||False|
|forwarding_configuration|cache_query_parameter_strip_directive| Defines cache behaviour in relation to query string parameters. Valid options are `StripAll`, `StripAllExcept`, `StripOnly` or `StripNone`. Defaults to `StripAll`.|||False|
|forwarding_configuration|cache_query_parameters| Specify query parameters (array). Works only in combination with `cache_query_parameter_strip_directive` set to `StripAllExcept` or `StripOnly`.|||False|
|forwarding_configuration|cache_duration| Specify the caching duration (in ISO8601 notation e.g. `P1DT2H` for 1 day and 2 hours). Needs to be greater than 0 and smaller than 365 days. `cache_duration` works only in combination with `cache_enabled` set to `true`.|||False|
|forwarding_configuration|custom_forwarding_path| Path to use when constructing the request to forward to the backend. This functions as a URL Rewrite. Default behaviour preserves the URL path.|||False|
|forwarding_configuration|forwarding_protocol| Protocol to use when redirecting. Valid options are `HttpOnly`, `HttpsOnly`, or `MatchRequest`. Defaults to `HttpsOnly`.|||False|
|routing_rule|redirect_configuration||||False|
|redirect_configuration|custom_host|  Set this to change the URL for the redirection.|||False|
|redirect_configuration|redirect_protocol| Protocol to use when redirecting. Valid options are `HttpOnly`, `HttpsOnly`, or `MatchRequest`. Defaults to `MatchRequest`|||False|
|redirect_configuration|redirect_type| Status code for the redirect. Valida options are `Moved`, `Found`, `TemporaryRedirect`, `PermanentRedirect`.|||True|
|redirect_configuration|custom_fragment| The destination fragment in the portion of URL after '#'. Set this to add a fragment to the redirect URL.|||False|
|redirect_configuration|custom_path| The path to retain as per the incoming request, or update in the URL for the redirection.|||False|
|redirect_configuration|custom_query_string| Replace any existing query string from the incoming request URL.|||False|

## Outputs
| Name | Description |
|------|-------------|
|backend_pool_health_probes|A map/dictionary of Backend Pool Health Probe Names (key) to the Backend Pool Health Probe ID (value)|||
|backend_pool_load_balancing_settings|A map/dictionary of Backend Pool Load Balancing Setting Names (key) to the Backend Pool Load Balancing Setting ID (value)|||
|backend_pools|A map/dictionary of Backend Pool Names (key) to the Backend Pool ID (value)|||
|frontend_endpoints|A map/dictionary of Frontend Endpoint Names (key) to the Frontend Endpoint ID (value)|||
|routing_rules|A map/dictionary of Routing Rule Names (key) to the Routing Rule ID (value)|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# frontdoor_firewall_policy

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the policy. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|enabled| Is the policy a enabled state or disabled state. Defaults to `true`.||False|
|mode| The firewall policy mode. Possible values are `Detection`, `Prevention` and defaults to `Prevention`.||False|
|redirect_url| If action type is redirect, this field represents redirect URL for the client.||False|
|custom_rule| One or more `custom_rule` blocks as defined below.| Block |False|
|custom_block_response_status_code| If a `custom_rule` block's action type is `block`, this is the response status code. Possible values are `200`, `403`, `405`, `406`, or `429`.||False|
|custom_block_response_body| If a `custom_rule` block's action type is `block`, this is the response body. The body must be specified in base64 encoding.||False|
|managed_rule| One or more `managed_rule` blocks as defined below.| Block |False|
|tags| A mapping of tags to assign to the Web Application Firewall Policy.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|custom_rule|name| Gets name of the resource that is unique within a policy. This name can be used to access the resource.|||True|
|custom_rule|action| The action to perform when the rule is matched. Possible values are `Allow`, `Block`, `Log`, or `Redirect`.|||True|
|custom_rule|enabled| Is the rule is enabled or disabled? Defaults to `true`.|||False|
|custom_rule|priority| The priority of the rule. Rules with a lower value will be evaluated before rules with a higher value. Defaults to `1`.|||True|
|custom_rule|type| The type of rule. Possible values are `MatchRule` or `RateLimitRule`.|||True|
|custom_rule|match_condition| One or more `match_condition` block defined below. Can support up to `10` `match_condition` blocks.|||True|
|match_condition|match_variable| The request variable to compare with. Possible values are `Cookies`, `PostArgs`, `QueryString`, `RemoteAddr`, `RequestBody`, `RequestHeader`, `RequestMethod`, `RequestUri`, or `SocketAddr`.|||True|
|match_condition|match_values| Up to `600` possible values to match. Limit is in total across all `match_condition` blocks and `match_values` arguments. String value itself can be up to `256` characters long.|||True|
|match_condition|operator| Comparison type to use for matching with the variable value. Possible values are `Any`, `BeginsWith`, `Contains`, `EndsWith`, `Equal`, `GeoMatch`, `GreaterThan`, `GreaterThanOrEqual`, `IPMatch`, `LessThan`, `LessThanOrEqual` or `RegEx`.|||True|
|match_condition|selector| Match against a specific key if the `match_variable` is `QueryString`, `PostArgs`, `RequestHeader` or `Cookies`.|||False|
|match_condition|negation_condition| Should the result of the condition be negated.|||False|
|match_condition|transforms| Up to `5` transforms to apply. Possible values are `Lowercase`, `RemoveNulls`, `Trim`, `Uppercase`, `URLDecode` or`URLEncode`.|||False|
|custom_rule|rate_limit_duration_in_minutes| The rate limit duration in minutes. Defaults to `1`.|||False|
|custom_rule|rate_limit_threshold| The rate limit threshold. Defaults to `10`.|||False|
|managed_rule|type| The name of the managed rule to use with this resource.|||True|
|managed_rule|version| The version on the managed rule to use with this resource.|||True|
|managed_rule|exclusion| One or more `exclusion` blocks as defined below.|||False|
|exclusion|match_variable| The variable type to be excluded. Possible values are `QueryStringArgNames`, `RequestBodyPostArgNames`, `RequestCookieNames`, `RequestHeaderNames`.|||True|
|exclusion|operator| Comparison operator to apply to the selector when specifying which elements in the collection this exclusion applies to. Possible values are: `Equals`, `Contains`, `StartsWith`, `EndsWith`, `EqualsAny`.|||True|
|exclusion|selector| Selector for the value in the `match_variable` attribute this exclusion applies to.|||True|
|managed_rule|override| One or more `override` blocks as defined below.|||False|
|override|rule_group_name| The managed rule group to override.|||True|
|override|exclusion| One or more `exclusion` blocks as defined below.|||False|
|exclusion|match_variable| The variable type to be excluded. Possible values are `QueryStringArgNames`, `RequestBodyPostArgNames`, `RequestCookieNames`, `RequestHeaderNames`.|||True|
|exclusion|operator| Comparison operator to apply to the selector when specifying which elements in the collection this exclusion applies to. Possible values are: `Equals`, `Contains`, `StartsWith`, `EndsWith`, `EqualsAny`.|||True|
|exclusion|selector| Selector for the value in the `match_variable` attribute this exclusion applies to.|||True|
|override|rule| One or more `rule` blocks as defined below. If none are specified, all of the rules in the group will be disabled.|||False|
|rule|rule_id| Identifier for the managed rule.|||True|
|rule|action| The action to be applied when the rule matches. Possible values are `Allow`, `Block`, `Log`, or `Redirect`.|||True|
|rule|enabled| Is the managed rule override enabled or disabled. Defaults to `false`|||False|
|rule|exclusion| One or more `exclusion` blocks as defined below.|||False|
|exclusion|match_variable| The variable type to be excluded. Possible values are `QueryStringArgNames`, `RequestBodyPostArgNames`, `RequestCookieNames`, `RequestHeaderNames`.|||True|
|exclusion|operator| Comparison operator to apply to the selector when specifying which elements in the collection this exclusion applies to. Possible values are: `Equals`, `Contains`, `StartsWith`, `EndsWith`, `EqualsAny`.|||True|
|exclusion|selector| Selector for the value in the `match_variable` attribute this exclusion applies to.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the FrontDoor Firewall Policy.|||
|location|The Azure Region where this FrontDoor Firewall Policy exists.|||
|frontend_endpoint_ids|The Frontend Endpoints associated with this Front Door Web Application Firewall policy.|||
