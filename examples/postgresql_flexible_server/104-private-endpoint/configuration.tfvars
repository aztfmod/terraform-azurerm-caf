global_settings = {
  default_region = "region1"
  regions = {
    region1 = "uksouth"
  }
}

resource_groups = {
  postgresql_region1 = {
    name   = "postgresql-region1"
    region = "region1"
  }
}

postgresql_flexible_servers = {
  primary_region1 = {
    name       = "primary-region1"
    region     = "region1"
    version    = "12"
    sku_name   = "MO_Standard_E4s_v3"
    zone       = 1
    storage_mb = 131072

    resource_group = {
      key = "postgresql_region1"
      # lz_key = ""                           # Set the lz_key if the resource group is remote.
    }

    # Auto-generated administrator credentials stored in azure keyvault when not set (recommended).
    # administrator_username  = "postgresqladmin"
    # administrator_password  = "ComplxP@ssw0rd!"
    keyvault = {
      key = "postgresql_region1" # (Required) when auto-generated administrator credentials needed.
      # lz_key      = ""                      # Set the lz_key if the keyvault is remote.
    }

    # [Optional] Firewall Rules
    postgresql_firewall_rules = {
      postgresql-firewall-rule1 = {
        name             = "postgresql-firewall-rule1"
        start_ip_address = "10.0.1.10"
        end_ip_address   = "10.0.1.11"
      }
      postgresql-firewall-rule2 = {
        name             = "postgresql-firewall-rule2"
        start_ip_address = "10.0.2.10"
        end_ip_address   = "10.0.2.11"
      }
    }

    # [Optional] Server Configurations
    postgresql_configurations = {
      backslash_quote = {
        name  = "backslash_quote"
        value = "on"
      }
      bgwriter_delay = {
        name  = "bgwriter_delay"
        value = "25"
      }
    }


    postgresql_databases = {
      sampledb1 = {
        name = "sampledb1"
      }
      sampledb2 = {
        name        = "sampledb2"
        passthrough = true
      }
    }

    private_endpoints = {
      pe1 = {
        name               = "pe1"
        vnet_key           = "vnet_region1"
        subnet_key         = "private_endpoints"
        resource_group_key = "postgresql_region1"

        private_service_connection = {
          name                 = "pe1"
          is_manual_connection = false
          subresource_names    = ["postgresqlServer"]
        }

        private_dns = {
          zone_group_name = "postgres"
          keys            = ["postgres"]
        }
      }
    }

    tags = {
      segment = "sales"
    }

  }

}

# Store the postgresql_flexible_server administrator credentials into keyvault if the attribute keyvault{} block is defined.
keyvaults = {
  postgresql_region1 = {
    name                = "akv"
    resource_group_key  = "postgresql_region1"
    sku_name            = "standard"
    soft_delete_enabled = true
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}

## Networking configuration
vnets = {
  vnet_region1 = {
    resource_group_key = "postgresql_region1"
    region             = "region1"

    vnet = {
      name          = "postgresql"
      address_space = ["10.10.0.0/24"]
    }

    subnets = {
      private_endpoints = {
        name                                           = "private-endpoint"
        cidr                                           = ["10.10.0.0/25"]
        enforce_private_link_endpoint_network_policies = true
      }
    }
  }
}

private_dns = {
  postgres = {
    name               = "privatelink.postgres.database.azure.com"
    resource_group_key = "postgresql_region1"
  }
}
