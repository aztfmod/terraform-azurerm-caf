data_factory = {
  preparation = {
    name = "example-prod-preparation-df"
    resource_group = {
      #lz_key = "it_dna_example_prod_resources"
      key = "preparation"
    }
    identity = {
      type = "SystemAssigned"
      #managed_identity_keys = ["data_factory"]
    }
  }
}

data_factory_integration_runtime_self_hosted = {
  adf_self_ir = {
    name = "example-prod-prep-run"
    data_factory = {
      key = "preparation"
    }
    resource_group = {
      #lz_key = "it_dna_example_prod_resources"
      key = "preparation"
    }
  }
}
data_factory_linked_service_azure_databricks = {
  preparation = {
    name = "example-prod-preparation-ls"
    data_factory = {
      key = "preparation"
    }
    resource_group = {
      #lz_key = "it_dna_example_prod_resources"
      key = "preparation"
    }
    databricks_workspace = {
      key = "prepprod"
      #lz_key    = ""
      #id        = ""
      #adb_domain          = "https://${azurerm_databricks_workspace.example.workspace_url}"
    }
    new_cluster_config = {
      cluster_version       = "3.2.x-scala2.12"
      node_type             = "Standard_D8_v3"
      driver_node_type      = "Standard_D3_v2"
      log_destination       = "dbfs:/cluster-logs-preparation"
      min_number_of_workers = 1
      max_number_of_workers = 10
    }
  }
  modeling = {
    name = "example-prod-modeling"
    data_factory = {
      key = "preparation"
    }
    resource_group = {
      #lz_key = "it_dna_example_prod_resources"
      key = "preparation"
    }
    databricks_workspace = {
      key = "modprod"
      #lz_key    = ""
      #id        = ""
      #adb_domain          = "https://${azurerm_databricks_workspace.example.workspace_url}"
    }
    new_cluster_config = {
      cluster_version       = "3.2.x-scala2.12"
      node_type             = "Standard_D8_v3"
      driver_node_type      = "Standard_D3_v2"
      log_destination       = "dbfs:/cluster-logs-modeling"
      min_number_of_workers = 1
      max_number_of_workers = 10
    }
  }
}
