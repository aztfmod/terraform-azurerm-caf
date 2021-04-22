# Azure Cosmos DB

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_cosmos_db" {
  source  = "aztfmod/caf/azurerm//modules/databases/cosmos_db"
  version = "4.21.2"
  # insert the 5 required variables here
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurecaf | n/a |
| azurerm | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| cassandra_keyspaces | ./cassandra_keyspace |  |
| gremlin_databases | ./gremlin_database |  |
| mongo_databases | ./mongo_database |  |
| sql_databases | ./sql_database |  |
| tables | ./table |  |

## Resources

| Name |
|------|
| [azurecaf_name](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) |
| [azurerm_cosmosdb_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map(any)` | n/a | yes |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| location | (Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| resource\_group\_name | (Required) The name of the resource group where to create the resource. | `string` | n/a | yes |
| settings | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cassandra\_keyspaces | n/a |
| connection\_string | n/a |
| cosmos\_account | n/a |
| endpoint | n/a |
| gremlin\_databases | n/a |
| mongo\_databases | n/a |
| primary\_key | n/a |
| sql\_databases | n/a |
| tables | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->