global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  evg_examples = {
    name   = "eventgrid"
    region = "region1"
  }
}

storage_accounts = {
  sa1 = {
    name               = "0665ba08d3ae"
    resource_group_key = "evg_examples"
    account_kind       = "BlobStorage"
    account_tier       = "Standard"
    # account_replication_type = "LRS"
    containers = {
      dev = {
        name = "random"
      }
    }
  }
}

eventgrid_system_topic = {
  egt1 = {
    name = "egt1"
    resource_group = {
      key = "evg_examples"
    }
    region = "region1"

    # topic_type can be one of these, more resource types can be supported
    # Microsoft.AppConfiguration.ConfigurationStores
    # Microsoft.Communication.CommunicationServices
    # Microsoft.ContainerRegistry.Registries
    # Microsoft.Devices.IoTHubs
    # Microsoft.EventGrid.Domains
    # Microsoft.EventGrid.Topics
    # Microsoft.Eventhub.Namespaces
    # Microsoft.KeyVault.vaults
    # Microsoft.MachineLearningServices.Workspaces
    # Microsoft.Maps.Accounts
    # Microsoft.Media.MediaServices
    # Microsoft.Resources.ResourceGroups
    # Microsoft.Resources.Subscriptions
    # Microsoft.ServiceBus.Namespaces
    # Microsoft.SignalRService.SignalR
    # Microsoft.Storage.StorageAccounts
    # Microsoft.Web.ServerFarms
    # Microsoft.Web.Sites
    topic_type = "Microsoft.Storage.StorageAccounts"

    source_resource = {
      type = "storage_accounts"
      key  = "sa1"
    }
  }
}
