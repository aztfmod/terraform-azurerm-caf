
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus"
  }
}

resource_groups = {
  rg1 = {
    name   = "example-agw"
    region = "region1"
  }
}
storage_accounts = {
  sa1 = {
    name                     = "sa1"
    resource_group_key       = "rg1"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}
storage_data_lake_gen2_filesystem = {
  sdlg21 = {
    name = "example"
    storage_account = {
      key = "sa1"
    }
  }
}

synapse_workspace = {
  syws1 = {
    name = "example"
    resource_group = {
      key = "rg1"
    }
    location = "region1"
    storage_data_lake_gen2_filesystem = {
      key = "sdlg21"
    }
    sql_administrator_login          = "sqladminuser"
    sql_administrator_login_password = "H@Sh1CoR3!"
    tags = {
      Env = "production"
    }
  }
}

synapse_firewall_rule = {
  sybfw1 = {
    name = "AllowAll"
    synapse_workspace = {
      key = "syws1"
    }
    start_ip_address = "0.0.0.0"
    end_ip_address   = "255.255.255.255"
  }
}

synapse_linked_service = {
  sls1 = {
    name = "example"
    synapse_workspace = {
      key = "syws1"
    }
    type                 = "AzureBlobStorage"
    type_properties_json = <<JSON
{
  "connectionString": ""
}
JSON
  }
}