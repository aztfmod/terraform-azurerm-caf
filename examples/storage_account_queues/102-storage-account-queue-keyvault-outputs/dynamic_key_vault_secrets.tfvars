dynamic_keyvault_secrets = {
    # Emits the primary queue endpoint from the storage accounts module to KeyVault
    QUEUE-CONN-STRING = {
      secret_name   = "QUEUE-STORAGE-URI"
      output_key    = "storage_accounts"
      resource_key  = "gears_storage"
      attribute_key = "primary_queue_endpoint"
    }
    # Emits the queue name from the queues module to KeyVault
    QUEUE-NAME = {
      output_key    = "storage_account_queues"
      resource_key  = "samplequeue"
      attribute_key = "queue_name"
      secret_name   = "QUEUE-NAME"
    }
  }
}