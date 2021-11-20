
# cdn_endpoint

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the CDN Endpoint. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|profile_name| The CDN Profile to which to attach the CDN Endpoint.||True|
| region |The region_key where the resource will be deployed|String|True|
|is_http_allowed| Defaults to `true`.||False|
|is_https_allowed| Defaults to `true`.||False|
|content_types_to_compress| An array of strings that indicates a content types on which compression will be applied. The value for the elements should be MIME types.||False|
|geo_filter| A set of Geo Filters for this CDN Endpoint. Each `geo_filter` block supports fields documented below.| Block |False|
|is_compression_enabled| Indicates whether compression is to be enabled.||False|
|querystring_caching_behaviour| Sets query string caching behavior. Allowed values are `IgnoreQueryString`, `BypassCaching` and `UseQueryString`. `NotSet` value can be used for `Premium Verizon` CDN profile. Defaults to `IgnoreQueryString`.||False|
|optimization_type| What types of optimization should this CDN Endpoint optimize for? Possible values include `DynamicSiteAcceleration`, `GeneralMediaStreaming`, `GeneralWebDelivery`, `LargeFileDownload` and `VideoOnDemandMediaStreaming`.||False|
|origin| The set of origins of the CDN endpoint. When multiple origins exist, the first origin will be used as primary and rest will be used as failover options. Each `origin` block supports fields documented below.| Block |True|
|origin_host_header| The host header CDN provider will send along with content requests to origins.||False|
|origin_path| The path used at for origin requests.||False|
|probe_path| the path to a file hosted on the origin which helps accelerate delivery of the dynamic content and calculate the most optimal routes for the CDN. This is relative to the `origin_path`.||False|
|global_delivery_rule| Actions that are valid for all resources regardless of any conditions. A `global_delivery_rule` block as defined below.| Block |False|
|delivery_rule| Rules for the rules engine. An endpoint can contain up until 4 of those rules that consist of conditions and actions. A `delivery_rule` blocks as defined below.| Block |False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|geo_filter|relative_path| The relative path applicable to geo filter.|||True|
|geo_filter|action| The Action of the Geo Filter. Possible values include `Allow` and `Block`.|||True|
|geo_filter|country_codes| A List of two letter country codes (e.g. `US`, `GB`) to be associated with this Geo Filter.|||True|
|origin|name| The name of the origin. This is an arbitrary value. However, this value needs to be unique under the endpoint. Changing this forces a new resource to be created.|||True|
|origin|host_name| A string that determines the hostname/IP address of the origin server. This string can be a domain name, Storage Account endpoint, Web App endpoint, IPv4 address or IPv6 address. Changing this forces a new resource to be created.|||True|
|origin|http_port| The HTTP port of the origin. Defaults to `80`. Changing this forces a new resource to be created.|||False|
|origin|https_port||||False|
|global_delivery_rule|cache_expiration_action| A `cache_expiration_action` block as defined above.|||False|
|cache_expiration_action|behavior| The behavior of the cache. Valid values are `BypassCache`, `Override` and `SetIfMissing`.|||True|
|cache_expiration_action|duration| Duration of the cache. Only allowed when `behavior` is set to `Override` or `SetIfMissing`. Format: `[d.]hh:mm:ss`|||False|
|global_delivery_rule|cache_key_query_string_action| A `cache_key_query_string_action` block as defined above.|||False|
|cache_key_query_string_action|behavior| The behavior of the cache key for query strings. Valid values are `Exclude`, `ExcludeAll`, `Include` and `IncludeAll`.|||True|
|cache_key_query_string_action|parameters| Comma separated list of parameter values.|||False|
|global_delivery_rule|modify_request_header_action| A `modify_request_header_action` block as defined below.|||False|
|modify_request_header_action|action| Action to be executed on a header value. Valid values are `Append`, `Delete` and `Overwrite`.|||True|
|modify_request_header_action|name| The header name.|||True|
|modify_request_header_action|value| The value of the header. Only needed when `action` is set to `Append` or `overwrite`.|||False|
|global_delivery_rule|modify_response_header_action| A `modify_response_header_action` block as defined below.|||False|
|modify_response_header_action|action| Action to be executed on a header value. Valid values are `Append`, `Delete` and `Overwrite`.|||True|
|modify_response_header_action|name| The header name.|||True|
|modify_response_header_action|value| The value of the header. Only needed when `action` is set to `Append` or `overwrite`.|||False|
|global_delivery_rule|url_redirect_action| A `url_redirect_action` block as defined below.|||False|
|url_redirect_action|redirect_type| Type of the redirect. Valid values are `Found`, `Moved`, `PermanentRedirect` and `TemporaryRedirect`.|||True|
|url_redirect_action|protocol| Specifies the protocol part of the URL. Valid values are `Http` and `Https`.|||False|
|url_redirect_action|hostname| Specifies the hostname part of the URL.|||False|
|url_redirect_action|path| Specifies the path part of the URL. This value must begin with a `/`.|||False|
|url_redirect_action|fragment| Specifies the fragment part of the URL. This value must not start with a `#`.|||False|
|url_redirect_action|query_string| Specifies the query string part of the URL. This value must not start with a `?` or `&` and must be in `<key>=<value>` format separated by `&`.|||False|
|global_delivery_rule|url_rewrite_action| A `url_rewrite_action` block as defined below.|||False|
|url_rewrite_action|source_pattern| This value must start with a `/` and can't be longer than 260 characters.|||True|
|url_rewrite_action|destination| This value must start with a `/` and can't be longer than 260 characters.|||True|
|url_rewrite_action|preserve_unmatched_path| Defaults to `true`.|||False|
|delivery_rule|name| The Name which should be used for this Delivery Rule.|||True|
|delivery_rule|order| The order used for this rule, which must be larger than 1.|||True|
|delivery_rule|cache_expiration_action| A `cache_expiration_action` block as defined above.|||False|
|cache_expiration_action|behavior| The behavior of the cache. Valid values are `BypassCache`, `Override` and `SetIfMissing`.|||True|
|cache_expiration_action|duration| Duration of the cache. Only allowed when `behavior` is set to `Override` or `SetIfMissing`. Format: `[d.]hh:mm:ss`|||False|
|delivery_rule|cache_key_query_string_action| A `cache_key_query_string_action` block as defined above.|||False|
|cache_key_query_string_action|behavior| The behavior of the cache key for query strings. Valid values are `Exclude`, `ExcludeAll`, `Include` and `IncludeAll`.|||True|
|cache_key_query_string_action|parameters| Comma separated list of parameter values.|||False|
|delivery_rule|cookies_condition| A `cookies_condition` block as defined above.|||False|
|cookies_condition|selector| Name of the cookie.|||True|
|cookies_condition|operator| Valid values are `Any`, `BeginsWith`, `Contains`, `EndsWith`, `Equal`, `GreaterThan`, `GreaterThanOrEqual`, `LessThan` and `LessThanOrEqual`.|||True|
|cookies_condition|negate_condition| Defaults to `false`.|||False|
|cookies_condition|match_values| List of values for the cookie. This is required if `operator` is not `Any`.|||False|
|cookies_condition|transforms| Valid values are `Lowercase` and `Uppercase`.|||False|
|delivery_rule|device_condition| A `device_condition` block as defined below.|||False|
|device_condition|operator| Valid values are `Equal`.|||False|
|device_condition|negate_condition| Defaults to `false`.|||False|
|device_condition|match_values| Valid values are `Desktop` and `Mobile`.|||True|
|delivery_rule|http_version_condition| A `http_version_condition` block as defined below.|||False|
|http_version_condition|operator| Valid values are `Equal`.|||False|
|http_version_condition|negate_condition| Defaults to `false`.|||False|
|http_version_condition|match_values| Valid values are `0.9`, `1.0`, `1.1` and `2.0`.|||True|
|delivery_rule|modify_request_header_action| A `modify_request_header_action` block as defined below.|||False|
|modify_request_header_action|action| Action to be executed on a header value. Valid values are `Append`, `Delete` and `Overwrite`.|||True|
|modify_request_header_action|name| The header name.|||True|
|modify_request_header_action|value| The value of the header. Only needed when `action` is set to `Append` or `overwrite`.|||False|
|delivery_rule|modify_response_header_action| A `modify_response_header_action` block as defined below.|||False|
|modify_response_header_action|action| Action to be executed on a header value. Valid values are `Append`, `Delete` and `Overwrite`.|||True|
|modify_response_header_action|name| The header name.|||True|
|modify_response_header_action|value| The value of the header. Only needed when `action` is set to `Append` or `overwrite`.|||False|
|delivery_rule|post_arg_condition| A `post_arg_condition` block as defined below.|||False|
|post_arg_condition|selector| Name of the post arg.|||True|
|post_arg_condition|operator| Valid values are `Any`, `BeginsWith`, `Contains`, `EndsWith`, `Equal`, `GreaterThan`, `GreaterThanOrEqual`, `LessThan` and `LessThanOrEqual`.|||True|
|post_arg_condition|negate_condition| Defaults to `false`.|||False|
|post_arg_condition|match_values| List of string values. This is required if `operator` is not `Any`.|||False|
|post_arg_condition|transforms| Valid values are `Lowercase` and `Uppercase`.|||False|
|delivery_rule|query_string_condition| A `query_string_condition` block as defined below.|||False|
|query_string_condition|operator| Valid values are `Any`, `BeginsWith`, `Contains`, `EndsWith`, `Equal`, `GreaterThan`, `GreaterThanOrEqual`, `LessThan` and `LessThanOrEqual`.|||True|
|query_string_condition|negate_condition| Defaults to `false`.|||False|
|query_string_condition|match_values| List of string values. This is required if `operator` is not `Any`.|||False|
|query_string_condition|transforms| Valid values are `Lowercase` and `Uppercase`.|||False|
|delivery_rule|remote_address_condition| A `remote_address_condition` block as defined below.|||False|
|remote_address_condition|operator| Valid values are `Any`, `GeoMatch` and `IPMatch`.|||True|
|remote_address_condition|negate_condition| Defaults to `false`.|||False|
|remote_address_condition|match_values| List of string values. For `GeoMatch` `operator` this should be a list of country codes (e.g. `US` or `DE`). List of IP address if `operator` equals to `IPMatch`. This is required if `operator` is not `Any`.|||False|
|delivery_rule|request_body_condition| A `request_body_condition` block as defined below.|||False|
|request_body_condition|operator| Valid values are `Any`, `BeginsWith`, `Contains`, `EndsWith`, `Equal`, `GreaterThan`, `GreaterThanOrEqual`, `LessThan` and `LessThanOrEqual`.|||True|
|request_body_condition|negate_condition| Defaults to `false`.|||False|
|request_body_condition|match_values| List of string values. This is required if `operator` is not `Any`.|||False|
|request_body_condition|transforms| Valid values are `Lowercase` and `Uppercase`.|||False|
|delivery_rule|request_header_condition| A `request_header_condition` block as defined below.|||False|
|request_header_condition|selector| Header name.|||True|
|request_header_condition|operator| Valid values are `Any`, `BeginsWith`, `Contains`, `EndsWith`, `Equal`, `GreaterThan`, `GreaterThanOrEqual`, `LessThan` and `LessThanOrEqual`.|||True|
|request_header_condition|negate_condition| Defaults to `false`.|||False|
|request_header_condition|match_values| List of header values. This is required if `operator` is not `Any`.|||False|
|request_header_condition|transforms| Valid values are `Lowercase` and `Uppercase`.|||False|
|delivery_rule|request_method_condition| A `request_method_condition` block as defined below.|||False|
|request_method_condition|operator| Valid values are `Equal`.|||False|
|request_method_condition|negate_condition| Defaults to `false`.|||False|
|request_method_condition|match_values| Valid values are `DELETE`, `GET`, `HEAD`, `OPTIONS`, `POST` and `PUT`.|||True|
|delivery_rule|request_scheme_condition| A `request_scheme_condition` block as defined below.|||False|
|request_scheme_condition|operator| Valid values are `Equal`.|||False|
|request_scheme_condition|negate_condition| Defaults to `false`.|||False|
|request_scheme_condition|match_values| Valid values are `HTTP` and `HTTPS`.|||True|
|delivery_rule|request_uri_condition| A `request_uri_condition` block as defined below.|||False|
|request_uri_condition|operator| Valid values are `Any`, `BeginsWith`, `Contains`, `EndsWith`, `Equal`, `GreaterThan`, `GreaterThanOrEqual`, `LessThan` and `LessThanOrEqual`.|||True|
|request_uri_condition|negate_condition| Defaults to `false`.|||False|
|request_uri_condition|match_values| List of string values. This is required if `operator` is not `Any`.|||False|
|request_uri_condition|transforms| Valid values are `Lowercase` and `Uppercase`.|||False|
|delivery_rule|url_file_extension_condition| A `url_file_extension_condition` block as defined below.|||False|
|url_file_extension_condition|operator| Valid values are `Any`, `BeginsWith`, `Contains`, `EndsWith`, `Equal`, `GreaterThan`, `GreaterThanOrEqual`, `LessThan` and `LessThanOrEqual`.|||True|
|url_file_extension_condition|negate_condition| Defaults to `false`.|||False|
|url_file_extension_condition|match_values| List of string values. This is required if `operator` is not `Any`.|||False|
|url_file_extension_condition|transforms| Valid values are `Lowercase` and `Uppercase`.|||False|
|delivery_rule|url_file_name_condition| A `url_file_name_condition` block as defined below.|||False|
|url_file_name_condition|operator| Valid values are `Any`, `BeginsWith`, `Contains`, `EndsWith`, `Equal`, `GreaterThan`, `GreaterThanOrEqual`, `LessThan` and `LessThanOrEqual`.|||True|
|url_file_name_condition|negate_condition| Defaults to `false`.|||False|
|url_file_name_condition|match_values| List of string values. This is required if `operator` is not `Any`.|||False|
|url_file_name_condition|transforms| Valid values are `Lowercase` and `Uppercase`.|||False|
|delivery_rule|url_path_condition| A `url_path_condition` block as defined below.|||False|
|url_path_condition|operator| Valid values are `Any`, `BeginsWith`, `Contains`, `EndsWith`, `Equal`, `GreaterThan`, `GreaterThanOrEqual`, `LessThan` and `LessThanOrEqual`.|||True|
|url_path_condition|negate_condition| Defaults to `false`.|||False|
|url_path_condition|match_values| List of string values. This is required if `operator` is not `Any`.|||False|
|url_path_condition|transforms| Valid values are `Lowercase` and `Uppercase`.|||False|
|delivery_rule|url_redirect_action| A `url_redirect_action` block as defined below.|||False|
|url_redirect_action|redirect_type| Type of the redirect. Valid values are `Found`, `Moved`, `PermanentRedirect` and `TemporaryRedirect`.|||True|
|url_redirect_action|protocol| Specifies the protocol part of the URL. Valid values are `Http` and `Https`.|||False|
|url_redirect_action|hostname| Specifies the hostname part of the URL.|||False|
|url_redirect_action|path| Specifies the path part of the URL. This value must begin with a `/`.|||False|
|url_redirect_action|fragment| Specifies the fragment part of the URL. This value must not start with a `#`.|||False|
|url_redirect_action|query_string| Specifies the query string part of the URL. This value must not start with a `?` or `&` and must be in `<key>=<value>` format separated by `&`.|||False|
|delivery_rule|url_rewrite_action| A `url_rewrite_action` block as defined below.|||False|
|url_rewrite_action|source_pattern| This value must start with a `/` and can't be longer than 260 characters.|||True|
|url_rewrite_action|destination| This value must start with a `/` and can't be longer than 260 characters.|||True|
|url_rewrite_action|preserve_unmatched_path| Defaults to `true`.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the CDN Endpoint.|||

---

# cdn_profile

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the CDN Profile. Changing this forces a||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|sku| The pricing related information of current CDN profile. Accepted values are `Standard_Akamai`, `Standard_ChinaCdn`, `Standard_Microsoft`, `Standard_Verizon` or `Premium_Verizon`.||True|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the CDN Profile.|||
