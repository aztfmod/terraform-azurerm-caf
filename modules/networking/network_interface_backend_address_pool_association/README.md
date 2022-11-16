module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# network_interface_backend_address_pool_association

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|network_interface|The `network_interface` block as defined below.|Block|True|
|ip_configuration_name| The Name of the IP Configuration within the Network Interface which should be connected to the Backend Address Pool. Changing this forces a new resource to be created.||True|
|backend_address_pool_id| The ID of the Load Balancer Backend Address Pool which this Network Interface should be connected to. Changing this forces a new resource to be created.||True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|network_interface| key | Key for  network_interface||| Required if  |
|network_interface| lz_key |Landing Zone Key in wich the network_interface is located|||True|
|network_interface| id | The id of the network_interface |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The (Terraform specific) ID of the Association between the Network Interface and the Load Balancers Backend Address Pool.|||
