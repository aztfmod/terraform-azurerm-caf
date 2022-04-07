module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# lb_backend_address_pool_address

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|backend_address_pool_id| The ID of the Backend Address Pool. Changing this forces a new Backend Address Pool Address to be created.||True|
|ip_address| The Static IP Address which should be allocated to this Backend Address Pool.||True|
|name| The name which should be used for this Backend Address Pool Address. Changing this forces a new Backend Address Pool Address to be created.||True|
|virtual_network|The `virtual_network` block as defined below.|Block|True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|virtual_network| key | Key for  virtual_network||| Required if  |
|virtual_network| lz_key |Landing Zone Key in wich the virtual_network is located|||True|
|virtual_network| id | The id of the virtual_network |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Backend Address Pool Address.|||
