databricks_workspaces = {
  prepprod = {
    name = "example-preparation-prod"
    sku  = "premium"
    custom_parameters = {
      no_public_ip       = true
      private_subnet_key = "private"
      public_subnet_key  = "egress"
      vnet_key           = "vnet"
      #lz_key             = "it_dna_example_prod_resources"
    }
    resource_group = {
      #lz_key = "it_dna_example_prod_resources"
      key = "analytics"
    }
  }
  modprod = {
    name = "example-modeling-prod"
    sku  = "premium"
    custom_parameters = {
      no_public_ip       = true
      private_subnet_key = "private"
      public_subnet_key  = "egress"
      vnet_key           = "vnet"
      #lz_key             = "it_dna_example_prod_resources"
    }
    resource_group = {
      #lz_key = "it_dna_example_prod_resources"
      key = "analytics2"
    }
  }
}