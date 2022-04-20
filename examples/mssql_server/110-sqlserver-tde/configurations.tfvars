# DEPLOYMENT NOTE:
# Due to the interdependence of mssql server, kv access policy and enablement of TDE, the sequence of deployment is as below
# 1. Leave TDE enablement = false as it will not work until server gets key management access to the KV
# 2. Once mssql server is created and assigned to the group membership in the first run, enable the TDE and re-run

global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

azuread_groups = {
  sqldbmsi_admins = {
    name        = "sqldbmsi-admins"
    description = "Administrators of the ep SQL server."
    members = {
      user_principal_names   = []
      object_ids             = []
      group_keys             = []
      service_principal_keys = []
    }
    owners = {
      user_principal_names = [
      ]
      service_principal_keys = []
      object_ids             = []
    }
    prevent_duplicate_name = false
  }
}

azuread_groups_membership = { # the dependency of kv access policy with mssql_server id is cyclic by nature, mssql_server > kv_access_policy > tde enablement
  sqldbmsi_admins = {         # group key
    mssql_servers = {
      server1 = { # name of the map
        # group_lz_key = "" # group lz_key
        # lz_key = ""       # mssql_server lz_key
        keys = ["mssqlserver1"] # to assign this group with kv access policy
      }
    }
  }
}

azuread_roles = {
  mssql_servers = {
    mssqlserver1 = {
      roles = ["Directory Readers"]
    }
  }
}


resource_groups = {

  rg1 = {
    name   = "sqldbmsitest"
    region = "region1"
  }
}

managed_identities = {
  sqldbmsi = {
    name               = "sqldbmsi"
    resource_group_key = "rg1"
  }
}

# Vnets for network rule demonstration
vnets = {
  vnet1 = {
    resource_group_key = "rg1"
    vnet = {
      name          = "testvnet1"
      address_space = ["10.0.0.0/16"]
    }
    subnets = {
      web = {
        name              = "web-subnet"
        cidr              = ["10.0.1.0/24"]
        service_endpoints = ["Microsoft.Sql"]
      }
    }
  }
}

mssql_servers = {
  mssqlserver1 = {
    name                          = "mssqlserver1"
    region                        = "region1"
    resource_group_key            = "rg1"
    version                       = "12.0"
    administrator_login           = "sqladmin"
    administrator_login_password  = "joasdif2384u89#@^"
    connection_policy             = "Default"
    public_network_access_enabled = true
    minimum_tls_version           = "1.2"

    identity = {
      type = "SystemAssigned"
    }

    azuread_administrator = {
      azuread_group_key = "sqldbmsi_admins"
    }

    firewall_rules = {
      rule1 = {
        name             = "testrule1"
        start_ip_address = "124.82.37.221"
        end_ip_address   = "124.82.37.221"
      }
    }

    network_rules = {
      rule1 = {
        name       = "testrule1"
        vnet_key   = "vnet1"
        subnet_key = "web"
      }
    }

    transparent_data_encryption = { # the dependency of kv access policy with mssql_server id is cyclic by nature, mssql_server > kv_access_policy > tde enablement
      enable = false                # NOTE: Enable this AFTER deployment of the mssql server and kv access policy assignment.
      encryption_key = {
        # lz_key = ""
        keyvault_key_key = "key1" # encryption key reference of the keyvault key
      }
    }


  }
}

keyvaults = {
  kv1 = {
    name               = "sqldbmsikv"
    resource_group_key = "rg1"
    sku_name           = "standard"
    creation_policies = {
      sqldbmsi_admins = {                      # the dependency of kv access policy with mssql_server id is cyclic by nature, mssql_server > kv_access_policy > tde enablement
        azuread_group_key  = "sqldbmsi_admins" # add users/msi/sp on ad group member to gain permission
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
        key_permissions    = ["Create", "Decrypt", "Delete", "Encrypt", "Get", "List", "Purge", "UnwrapKey", "WrapKey"]

      }
    }
  }
}

keyvault_keys = {
  key1 = {
    # lz_key = ""
    keyvault_key = "kv1"

    name     = "tdekey"
    key_type = "RSA"
    key_size = 2048
    key_opts = ["unwrapKey", "wrapKey"]
  }
}