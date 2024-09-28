terraform {
  required_providers {
  }
  required_version = ">= 1.3.0"
}


provider "azurerm" {
  features {
    api_management {
      purge_soft_delete_on_destroy = var.provider_azurerm_features_api_management.purge_soft_delete_on_destroy
      # recover_soft_deleted_api_managements = var.provider_azurerm_features_api_management.recover_soft_deleted_api_managements
    }
    # application_insights {
    #   disable_generated_rule = var.provider_azurerm_features_application_insights.disable_generated_rule
    # }
    cognitive_account {
      purge_soft_delete_on_destroy = var.provider_azurerm_features_cognitive_account.purge_soft_delete_on_destroy
    }
    key_vault {
      purge_soft_delete_on_destroy = var.provider_azurerm_features_keyvault.purge_soft_delete_on_destroy
      # purge_soft_deleted_certificates_on_destroy = var.provider_azurerm_features_keyvault.purge_soft_deleted_certificates_on_destroy
      # purge_soft_deleted_keys_on_destroy         = var.provider_azurerm_features_keyvault.purge_soft_deleted_keys_on_destroy
      # purge_soft_deleted_secrets_on_destroy      = var.provider_azurerm_features_keyvault.purge_soft_deleted_secrets_on_destroy
      # recover_soft_deleted_certificates          = var.provider_azurerm_features_keyvault.recover_soft_deleted_certificates
      recover_soft_deleted_key_vaults = try(var.provider_azurerm_features_keyvault.recover_soft_deleted_key_vaults, null)
      # recover_soft_deleted_keys                  = var.provider_azurerm_features_keyvault.recover_soft_deleted_keys
      # recover_soft_deleted_secrets               = var.provider_azurerm_features_keyvault.recover_soft_deleted_secrets
    }
    # log_analytics_workspace {
    #   permanently_delete_on_destroy = var.provider_azurerm_features_log_analytics_workspace.permanently_delete_on_destroy
    # }
    resource_group {
      prevent_deletion_if_contains_resources = var.provider_azurerm_features_resource_group.prevent_deletion_if_contains_resources
    }
    template_deployment {
      delete_nested_items_during_deletion = var.provider_azurerm_features_template_deployment.delete_nested_items_during_deletion
    }
    virtual_machine {
      delete_os_disk_on_deletion     = var.provider_azurerm_features_virtual_machine.delete_os_disk_on_deletion
      graceful_shutdown              = var.provider_azurerm_features_virtual_machine.graceful_shutdown
      skip_shutdown_and_force_delete = var.provider_azurerm_features_virtual_machine.skip_shutdown_and_force_delete
    }
    virtual_machine_scale_set {
      force_delete                  = var.provider_azurerm_features_virtual_machine_scale_set.force_delete
      roll_instances_when_required  = var.provider_azurerm_features_virtual_machine_scale_set.roll_instances_when_required
      scale_to_zero_before_deletion = var.provider_azurerm_features_virtual_machine_scale_set.scale_to_zero_before_deletion
    }
  }
}

provider "azurerm" {
  alias                      = "vhub"
  skip_provider_registration = true
  subscription_id            = data.azurerm_client_config.default.subscription_id
  tenant_id                  = data.azurerm_client_config.default.tenant_id
  features {}
}


provider "azuread" {}

data "azurerm_client_config" "default" {}

locals {
  landingzone_tag = {
    "landingzone" = var.landingzone.key
  }

  tags = merge(local.landingzone_tag, var.tags, { "rover_version" = var.rover_version })
}