variable "global_settings" {
  description = <<DESCRIPTION
  Global settings object (see module README.md)
  DESCRIPTION
  type        = any
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
  type        = any
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}

variable "settings" {
  description = <<DESCRIPTION

  The settings object is a map of objects. Each object represents a Cognitive Service Account.

  The object has the following attributes:

  - `name`: (Required) The name of the Cognitive Service Account.
  - `kind`: (Required) The kind of Cognitive Service Account. Possible values are:
    - Academic, AnomalyDetector, Bing.Autosuggest, Bing.Autosuggest.v7, Bing.CustomSearch, Bing.Search, Bing.Search.v7, Bing.Speech, Bing.SpellCheck, Bing.SpellCheck.v7, CognitiveServices, ComputerVision, ContentModerator, ContentSafety, CustomSpeech, CustomVision.Prediction, CustomVision.Training, Emotion, Face, FormRecognizer, ImmersiveReader, LUIS, LUIS.Authoring, MetricsAdvisor, OpenAI, Personalizer, QnAMaker, Recommendations, SpeakerRecognition, Speech, SpeechServices, SpeechTranslation, TextAnalytics, TextTranslation, WebLM   
  - `sku_name`: (Required) The SKU name of the Cognitive Service Account. Possible values are:
    - F0,S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16,S17,S18,S19,S20,S21,S22,S23,S24,S25,S26,S27,S28,S29,S30,S31,S32,S33,S34,S35,S36,S37,S38,S39,S40,S41,S42,S43,S44,S45,S46,S47,S48,S49,S50,S51,S52,S53,S54,S55,S56,S57,S58,S59,S60,S61,S62,S63,S64,S65,S66,S67,S68,S69,S70,S71,S72,S73,S74,S75,S76,S77,S78,S79,S80,S81,S82,S83,S84,S85,S86,S87,S88,S89,S90,S91,S92,S93,S94,S95,S96,S97,S98
  - `custom_subdomain_name`: (Optional) The custom subdomain name of the Cognitive Service Account.
  - `dynamic_throttling_enabled`: (Optional) Specifies whether dynamic throttling is enabled for the Cognitive Service Account.
  - `customer_managed_key`: (Optional) The customer managed key configuration.
    - `key_vault_key_id`: (Required) The key vault key ID.
    - `identity_client_id`: (Optional) The identity client ID.
  - `fqdns`: (Optional) A list of fully qualified domain names (FQDNs) of the Cognitive Service Account.
  - `identity`: (Optional) The identity configuration.
    - `type`: (Required) The identity type.
    - `identity_ids`: (Optional) A list of identity IDs.
  - `local_auth_enabled`: (Optional) Specifies whether local authentication is enabled for the Cognitive Service Account.
  - `metrics_advisor_aad_client_id`: (Optional) The AAD client ID of the Metrics Advisor Cognitive Service Account.
  - `metrics_advisor_super_user_name`: (Optional) The super user name of the Metrics Advisor Cognitive Service Account.
  - `metrics_advisor_website_name`: (Optional) The website name of the Metrics Advisor Cognitive Service Account.
  - `network_acls`: (Optional) The network ACLs configuration.
    - `default_action`: (Required) The default action of the network ACLs.
    - `ip_rules`: (Optional) A list of IP rules.
    - `virtual_network_subnet_ids`: (Optional) A list of virtual network subnet IDs.
  - `outbound_network_access_restricted`: (Optional) Specifies whether outbound network access is restricted for the Cognitive Service Account.
  - `public_network_access_enabled`: (Optional) Specifies whether public network access is enabled for the Cognitive Service Account.
  - `qna_runtime_endpoint`: (Optional) The runtime endpoint of the QnA Maker Cognitive Service Account.
  - `custom_question_answering_search_service_id`: (Optional) The search service ID of the Text Analytics Cognitive Service Account.
  - `custom_question_answering_search_service_key`: (Optional) The search service key of the Text Analytics Cognitive Service Account.

  Example Input:

  ```terraform
  settings = {
    name = "cognitive-service-account"
    kind = "CognitiveServices"
    sku_name = "S0"
    custom_subdomain_name = "cognitive-service-account"
    dynamic_throttling_enabled = true
    customer_managed_key = {
      key_vault_key_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/resource-group/providers/Microsoft.KeyVault/vaults/key-vault/keys/key"
      identity_client_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/resource-group/providers/Microsoft.ManagedIdentity/userAssignedIdentities/identity"
    }
    fqdns = [
      "cognitive-service-account.azurewebsites.net"
    ]
    identity = {
      type = "SystemAssigned"
      identity_ids = []
    }
    local_auth_enabled = true
    metrics_advisor_aad_client_id = "00000000-0000-0000-0000-000000000000"
    metrics_advisor_super_user_name = "super-user"
    metrics_advisor_website_name = "website"
    network_acls = {
      default_action = "Allow"
      ip_rules = []
      virtual_network_subnet_ids = []
    }
    outbound_network_access_restricted = true
    public_network_access_enabled = true
    qna_runtime_endpoint = "https://cognitive-service-account.azurewebsites.net"
    custom_question_answering_search_service_id = "00000000-0000-0000-0000-000000000000"
    custom_question_answering_search_service_key = "key"
  }
  
  ```
  DESCRIPTION
  type = any
 # For the future, for now, doesn't work well with the validation block and with optional vars
 # type = object({
 #   name = string
 #   kind = string
 #   sku_name = string
 #   custom_subdomain_name = optional(string)
 #   dynamic_throttling_enabled = optional(bool)
 #   customer_managed_key = optional(object({
 #     key_vault_key_id =  string
 #     identity_client_id = optional(string)
 #   }),{})
 #   fqdns = optional(list(string))
 #   identity = optional(object({
 #     type = string
 #     identity_ids = optional(list(string))
 #   }),{})
 #   local_auth_enabled = optional(bool)
 #   metrics_advisor_aad_client_id = optional(string)
 #   metrics_advisor_super_user_name = optional(string)
 #   metrics_advisor_website_name = optional(string)
 #   network_acls = optional(object({
 #     default_action = string
 #     ip_rules = optional(list(string))
 #     virtual_network_subnet_ids = optional(list(string))
 #   }),{})
 #   outbound_network_access_restricted = optional(bool)
 #   public_network_access_enabled = optional(bool)
 #   qna_runtime_endpoint = optional(string)
 #   custom_question_answering_search_service_id = optional(string)
 #   custom_question_answering_search_service_key = optional(string)
 #   storage = optional(object({
 #     storage_account_id = string
 #     identity_client_id = optional(string)
 #   }))
 # })
  #validation {
  #  condition     = alltrue([
  #    for o in var.settings :
  #    contains(["Academic", "AnomalyDetector", "Bing.Autosuggest", "Bing.Autosuggest.v7", "Bing.CustomSearch", "Bing.Search", "Bing.Search.v7", "Bing.Speech", "Bing.SpellCheck", "Bing.SpellCheck.v7", "CognitiveServices", "ComputerVision", "ContentModerator", "ContentSafety", "CustomSpeech", "CustomVision.Prediction", "CustomVision.Training", "Emotion", "Face", "FormRecognizer", "ImmersiveReader", "LUIS", "LUIS.Authoring", "MetricsAdvisor", "OpenAI", "Personalizer", "QnAMaker", "Recommendations", "SpeakerRecognition", "Speech", "SpeechServices", "SpeechTranslation", "TextAnalytics", "TextTranslation", "WebLM"],o.kind) &&
  #    contains(["F0", "S0", "S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8", "S9", "S10", "S11", "S12", "S13", "S14", "S15", "S16", "S17", "S18", "S19", "S20", "S21", "S22", "S23", "S24", "S25", "S26", "S27", "S28", "S29", "S30", "S31", "S32", "S33", "S34", "S35", "S36", "S37", "S38", "S39", "S40", "S41", "S42", "S43", "S44", "S45", "S46", "S47", "S48", "S49", "S50", "S51", "S52", "S53", "S54", "S55", "S56", "S57", "S58", "S59", "S60", "S61", "S62", "S63", "S64", "S65", "S66", "S67", "S68", "S69", "S70", "S71", "S72", "S73", "S74", "S75", "S76", "S77", "S78", "S79", "S80", "S81", "S82", "S83", "S84", "S85", "S86", "S87", "S88", "S89", "S90", "S91", "S92", "S93", "S94", "S95", "S96", "S97", "S98", "S99", "S100", "S101", "S102", "S103", "S104", "S105", "S106", "S107", "S108", "S109", "S110", "S111", "S112", "S113", "S114", "S115", "S116", "S117", "S118", "S119", "S120", "S121", "S122"],o.sku_name)
  #  ])
  #  error_message = "Invalid value for settings"
  #}  
}


variable "remote_objects" {
  description = <<DESCRIPTION
  Remote objects is a map of objects. Each object represents a remote object that the Cognitive Service Account depends on.
  - `vnets`: (Optional) A map of virtual networks.
  - `virtual_subnets`: (Optional) A map of virtual subnets.
  DESCRIPTION
  type        = any
  default     = {}
}

variable "private_endpoints" {
  description = "A map of objects representing the private endpoints to create."
  type        = any
  # For the future
  #type        = map(object({
  #  name          = string
  #  lz_key        = string
  #  resource_group_key = string
  #  subnet_id     = optional(string)
  #  vnet_key      = string
  #  subnet_key    = string
  #}))
  default = {}
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}

variable "resource_group" {
  description = "Resource group object"
  type        = any
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Cognitive Service Account."
  type        = string
}