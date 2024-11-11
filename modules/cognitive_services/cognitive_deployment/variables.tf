variable "settings" {
  description = <<DESCRIPTION
    The settings object is used to define the configuration of the Azure Cognitive Services Account.
    The settings object is composed of the following properties:
    - name: The name of the Azure Cognitive Services Account.
    - model: The model object is used to define the configuration of the model.
      - format: The format of the model.
      - name: The name of the model.
      - version: The version of the model.
    - sku: The sku object is used to define the configuration of the sku.
      - name: The name of the sku.
      - tier: The tier of the sku.
      - size: The size of the sku.
      - family: The family of the sku.
      - capacity: The capacity of the sku.
    - rai_policy_name: The name of the RAI policy.
    - version_upgrade_option: The version upgrade option.
    Example Input:
    ```terraform
    settings = {
      name                = "cognitive-service"
      cognitive_account_id = "cognitive-account-id"
      model = {
        format  = "format"
        name    = "model-name"
        version = "model-version"
      }
      sku = {
        name     = "sku-name"
        tier     = "sku-tier"
        size     = "sku-size"
        family   = "sku-family"
        capacity = "sku-capacity"
      }
      rai_policy_name = "rai-policy-name"
      version_upgrade_option = "version-upgrade-option"
    }
    ```
DESCRIPTION
 type = any
/*
  # For the future, for now, doesn't work well with the validation block and with optional vars
  type = object({
    name                 = string
    model = object({
      format  = string
      name    = string
      version = optional(string)
    })
    sku = object({
      name     = string
      tier     = optional(string)
      size     = optional(string)
      family   = optional(string)
      capacity = optional(string)
    })
    rai_policy_name        = optional(string)
    version_upgrade_option = optional(string)
  })
  validation {
    condition = alltrue([
      for o in var.settings :
      contains(["OpenAI"], o.model.format)
    ])
    error_message = "Invalid value for settings"
  }
*/
}

variable "cognitive_account_id" {
  description = "The ID of the Azure Cognitive Services Account."
  type        = string
}
