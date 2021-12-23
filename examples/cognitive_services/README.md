module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# cognitive_account

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Cognitive Service Account. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|kind| Specifies the type of Cognitive Service Account that should be created. Possible values are `Academic`, `AnomalyDetector`, `Bing.Autosuggest`, `Bing.Autosuggest.v7`, `Bing.CustomSearch`, `Bing.Search`, `Bing.Search.v7`, `Bing.Speech`, `Bing.SpellCheck`, `Bing.SpellCheck.v7`, `CognitiveServices`, `ComputerVision`, `ContentModerator`, `CustomSpeech`, `CustomVision.Prediction`, `CustomVision.Training`, `Emotion`, `Face`,`FormRecognizer`, `ImmersiveReader`, `LUIS`, `LUIS.Authoring`, `MetricsAdvisor`, `Personalizer`, `QnAMaker`, `Recommendations`, `SpeakerRecognition`, `Speech`, `SpeechServices`, `SpeechTranslation`, `TextAnalytics`, `TextTranslation` and `WebLM`. Changing this forces a new resource to be created.||True|
|sku_name| Specifies the SKU Name for this Cognitive Service Account. Possible values are `F0`, `F1`, `S`, `S0`, `S1`, `S2`, `S3`, `S4`, `S5`, `S6`, `P0`, `P1`, and `P2`.||True|
|custom_subdomain_name| The subdomain name used for token-based authentication. Changing this forces a new resource to be created.||False|
|fqdns| List of FQDNs allowed for the Cognitive Account.||False|
|identity| An `identity` block as defined below.| Block |False|
|local_auth_enabled| Whether local authentication methods is enabled for the Cognitive Account. Defaults to `true`.||False|
|metrics_advisor_aad_client_id| The Azure AD Client ID (Application ID). This attribute is only set when kind is `MetricsAdvisor`. Changing this forces a new resource to be created.||False|
|metrics_advisor_aad_tenant_id| The Azure AD Tenant ID. This attribute is only set when kind is `MetricsAdvisor`. Changing this forces a new resource to be created.||False|
|metrics_advisor_super_user_name| The super user of Metrics Advisor. This attribute is only set when kind is `MetricsAdvisor`. Changing this forces a new resource to be created.||False|
|metrics_advisor_website_name| The website name of Metrics Advisor. This attribute is only set when kind is `MetricsAdvisor`. Changing this forces a new resource to be created.||False|
|network_acls| A `network_acls` block as defined below.| Block |False|
|outbound_network_access_restrited| Whether outbound network access is restricted for the Cognitive Account. Defaults to `false`.||False|
|public_network_access_enabled| Whether public network access is allowed for the Cognitive Account. Defaults to `true`.||False|
|qna_runtime_endpoint| A URL to link a QnAMaker cognitive account to a QnA runtime.||False|
|storage| A `storage` block as defined below.| Block |False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|identity|type| Specifies the type of Managed Service Identity that should be configured on the Cognitive Account. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both).|||True|
|identity|identity_ids| A list of IDs for User Assigned Managed Identity resources to be assigned.|||False|
|network_acls|default_action| The Default Action to use when no rules match from `ip_rules` / `virtual_network_subnet_ids`. Possible values are `Allow` and `Deny`.|||True|
|network_acls|ip_rules| One or more IP Addresses, or CIDR Blocks which should be able to access the Cognitive Account.|||False|
|network_acls|virtual_network_rules||||False|
|virtual_network_rules|subnet_id| The ID of the subnet which should be able to access this Cognitive Account.|||True|
|virtual_network_rules|ignore_missing_vnet_service_endpoint| Whether ignore missing vnet service endpoint or not. Default to `false`.|||False|
|storage|storage_account_id| Full resource id of a Microsoft.Storage resource.|||True|
|storage|identity_client_id| The client ID of the managed identity associated with the storage resource.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Cognitive Service Account.|||
|endpoint|The endpoint used to connect to the Cognitive Service Account.|||
|primary_access_key|A primary access key which can be used to connect to the Cognitive Service Account.|||
|secondary_access_key|The secondary access key which can be used to connect to the Cognitive Service Account.|||
