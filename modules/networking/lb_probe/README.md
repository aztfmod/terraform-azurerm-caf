module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# lb_probe

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the Probe.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|loadbalancer_id| The ID of the LoadBalancer in which to create the NAT Rule.||True|
|protocol| Specifies the protocol of the end point. Possible values are `Http`, `Https` or `Tcp`. If Tcp is specified, a received ACK is required for the probe to be successful. If Http is specified, a 200 OK response from the specified URI is required for the probe to be successful.||False|
|port| Port on which the Probe queries the backend endpoint. Possible values range from 1 to 65535, inclusive.||True|
|request_path| The URI used for requesting health status from the backend endpoint. Required if protocol is set to `Http` or `Https`. Otherwise, it is not allowed.||False|
|interval_in_seconds| The interval, in seconds between probes to the backend endpoint for health status. The default value is 15, the minimum value is 5.||False|
|number_of_probes| The number of failed probe attempts after which the backend endpoint is removed from rotation. The default value is 2. NumberOfProbes multiplied by intervalInSeconds value must be greater or equal to 10.Endpoints are returned to rotation when at least one probe is successful.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the Load Balancer Probe.|||
