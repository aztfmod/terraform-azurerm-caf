# Azure Virtual Network with Network Watcher

Creates a simple Azure Virtual Network test environment with Network Watcher, flow logs and traffic analytics enabled.

## Usage
To run this example, simply execute:

```hcl
terraform init
terraform plan
terraform apply
```

Once you are done, just run
```hcl
terraform destroy
```

## Outputs
| Name | Type | Description |
| -- | -- | -- |
| vnet | map(strings) | For a Vnet, returns: <br> -vnet_name <br> - vnet_adress_space <br> - vnet_id <br> - vnet_dns |
| vnet_obj | object | Returns the virtual network object with its full properties details. |
| subnet_ids_map | object | Returns all the subnets objects in the Virtual Network.  |
| nsg_obj | object | For all the subnets within the virtual network, returns the list subnets with their full details for user defined NSG. |
| vnet_subnets | map | Returns a map of subnets from the virtual network: <br> - key = subnet name <br> - value = subnet ID |
| nsg_vnet | string | Returns a map of nsg from the virtual network: <br>- key = nsg name <br>- value = nsg id |