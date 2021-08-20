# Azure Compute Resources

This module is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this directly using the following parameters:

```hcl
module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
  # insert the 7 required variables here
}

#vmware_clusters

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|name | Resource name | `string` |  | true |
|vmware_private_cloud_key | Key of the related vmware_private_cloud | `string` |  | true |
|cluster_node_count | Number of nodes | `number` |  | true |
|sku_name | Number of nodes [see below](#vmware_clusterssku_name). | `string` |  | true |

### Input Values
###vmware_clusters.sku_name
| Name | Description |
|------|-------------|
|av20||
|av36|Cores: 36	RAM:576GB	All Flash Storage:15.36TB	NVM Cache:3.2TB|
|av36t||

## Outputs
| Name | Description |
|------|-------------|
| id | The ID of the created vmware_cluster |
|cluster_number | A number that identifies this Vmware Cluster in its Vmware Private Cloud. |
|hosts | A list of host of the Vmware Cluster.
