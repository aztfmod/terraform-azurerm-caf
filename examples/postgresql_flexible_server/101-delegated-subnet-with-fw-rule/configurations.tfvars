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
  security_region1 = {
    name = "security-region1"
  }
}

postgresql_flexible_servers = {
  primary_region1 = {
    name       = "primary-region1"
    region     = "region1"
    version    = "12"
    sku_name   = "MO_Standard_E4s_v3"
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

    vnet = {
      key        = "vnet_region1"
      subnet_key = "postgresql"
      # lz_key      = ""                      # Set the lz_key if the vnet is remote.
    }

    private_dns_zone = {
      key = "dns1"
      # lz_key      = ""                      # Set the lz_key if the private_dns_zone is remote.
    }

    postgresql_firewall_rules = {
      pg_rule1 = {
        name             = "pg-fw-rule1"
        start_ip_address = "10.0.1.10"
        end_ip_address   = "10.0.1.11"
      }
      pg_rule2 = {
        name             = "pg-fw-rule2"
        start_ip_address = "10.0.2.10"
        end_ip_address   = "10.0.2.11"
      }
    }

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
      postgresql_database = {
        name      = "sampledb"
        charset   = "UTF8"
        collation = "English_United States.1252"
      }
    }

    tags = {
      segment = "sales"
    }

  }

}

## Keyvault configuration
keyvaults = {
  postgresql_region1 = {
    name                = "akv"
    resource_group_key  = "security_region1"
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
      private_dns = {
        name                                           = "private-dns"
        cidr                                           = ["10.10.0.0/25"]
        enforce_private_link_endpoint_network_policies = true
        enforce_private_link_service_network_policies  = false
      }
      postgresql = {
        name                                           = "postgresql"
        cidr                                           = ["10.10.0.128/25"]
        enforce_private_link_endpoint_network_policies = true
        delegation = {
          name               = "postgresql"
          service_delegation = "Microsoft.DBforPostgreSQL/flexibleServers"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action",
          ]
        }
      }
    }
  }

}

## Private DNS Configuration
private_dns = {
  dns1 = {
    name               = "sampledb.private.postgres.database.azure.com"
    resource_group_key = "postgresql_region1"

    # records = {}

    vnet_links = {
      vnlk1 = {
        name     = "postgresql-vnet-link"
        vnet_key = "vnet_region1"
        # lz_key   = ""
      }
    }

  }

}