You can test this module outside of a landingzone using

```bash
sudo terraform init

terraform [plan|apply|destroy] \
  -var-file ../configuration.tfvars \
  -var-file ../keyvaults.tfvars \
  -var-file ../nsg_definitions.tfvars \
  -var-file ../virtual_networks.tfvars \
  -var-file ../public_ip_addresses.tfvars \
  -var-file ../virtual_machines.tfvars


```

sudo terraform plan -var-file examples/networking/express_routes/configuration.tfvars

sudo terraform plan -var-file configuration.tfvars

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# express_route_circuit

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the ExpressRoute circuit. Changing this forces a new resource to be created.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
| region |The region_key where the resource will be deployed|String|True|
|sku| A `sku` block for the ExpressRoute circuit as documented below.||True|
|service_provider_name| The name of the ExpressRoute Service Provider. Changing this forces a new resource to be created.||False|
|peering_location| The name of the peering location and **not** the Azure resource location. Changing this forces a new resource to be created.||False|
|bandwidth_in_mbps| The bandwidth in Mbps of the circuit being created on the Service Provider.||False|
|allow_classic_operations| Allow the circuit to interact with classic (RDFE) resources. Defaults to `false`.||False|
|express_route_port|The `express_route_port` block as defined below.|Block|False|
|bandwidth_in_gbps| The bandwidth in Gbps of the circuit being created on the Express Route Port.||False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|express_route_port| key | Key for  express_route_port||| Required if  |
|express_route_port| lz_key |Landing Zone Key in wich the express_route_port is located|||False|
|express_route_port| id | The id of the express_route_port |||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the ExpressRoute circuit.|||
|service_provider_provisioning_state|The ExpressRoute circuit provisioning state from your chosen service provider. Possible values are "NotProvisioned", "Provisioning", "Provisioned", and "Deprovisioning".|||
|service_key|The string needed by the service provider to provision the ExpressRoute circuit.|||


module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# express_route_circuit_authorization

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the ExpressRoute circuit. Changing this forces a||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|express_route_circuit|The `express_route_circuit` block as defined below.|Block|True|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|express_route_circuit| key | Key for  express_route_circuit||| Required if  |
|express_route_circuit| lz_key |Landing Zone Key in wich the express_route_circuit is located|||True|
|express_route_circuit| name | The name of the express_route_circuit |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the ExpressRoute Circuit Authorization.|||
|authorization_key|The Authorization Key.|||
|authorization_use_status|The authorization use status.|||
