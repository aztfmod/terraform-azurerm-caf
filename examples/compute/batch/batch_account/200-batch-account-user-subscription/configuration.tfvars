# This example uses the Batch Account Pool Allocation Mode of "UserSubscription", which needs
# the Microsoft.Batch resource provider to be pre-registered on the target subscription, and
# the "Microsoft Azure Batch" enterprise application to be granted the "Contributor" role on
# the target subscription. See the following article for instructions on how to register the
# provider and grant the IAM role:
#
# https://docs.microsoft.com/en-us/azure/batch/batch-account-create-portal#additional-configuration-for-user-subscription-mode
#
# Note that this example requires you to substitute the "object id" of the "Microsoft Azure Batch"
# enterprise application from your AAD in the keyvault access policy block below.

global_settings = {
  default_region = "region1"
  environment    = "test"
  regions = {
    region1 = "eastus"
    region2 = "centralus"
    region3 = "westeurope"
  }
}

resource_groups = {
  batch_region1 = {
    name = "batch"
  }
}

batch_accounts = {
  batch1 = {
    name                 = "batch"
    resource_group_key   = "batch_region1"
    storage_account_key  = "batch_region1"
    pool_allocation_mode = "UserSubscription"
    # key_vault_key_key  = "batch" # required for "encryption" block, introduced in azurerm 2.99.0
    keyvault = {
      key = "batch_kv"
    }
  }
}

storage_accounts = {
  batch_region1 = {
    name                     = "batch"
    resource_group_key       = "batch_region1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}

keyvaults = {
  batch_kv = {
    name                   = "batch"
    resource_group_key     = "batch_region1"
    sku_name               = "standard"
    enabled_for_deployment = true
  }
}

# required for "encryption" block, introduced in azurerm 2.99.0
# keyvault_keys = {
#   batch = {
#     keyvault_key       = "batch_kv"
#     resource_group_key = "batch_region1"
#     name               = "batch"
#     key_type           = "RSA"
#     key_size           = "2048"
#     key_opts           = ["Encrypt", "Decrypt", "Sign", "Verify", "WrapKey", "UnwrapKey"]
#   }
# }

keyvault_access_policies = {
  batch_kv = {
    batch = {
      // substitute the object id of the "Microsoft Azure Batch" enterpise application from your AAD
      object_id          = "f65a395e-f3a2-453f-bafd-d242afdc0655"
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }
}
