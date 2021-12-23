module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# private_dns_zone

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| The name of the Private DNS Zone. Must be a valid domain name.||True|
|resource_group|The `resource_group` block as defined below.|Block|True|
|soa_record| An `soa_record` block as defined below. Changing this forces a new resource to be created.| Block |False|
|tags| A mapping of tags to assign to the resource.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|resource_group| key | Key for  resource_group||| Required if  |
|resource_group| lz_key |Landing Zone Key in wich the resource_group is located|||True|
|resource_group| name | The name of the resource_group |||True|
|soa_record|email| The email contact for the SOA record.|||True|
|soa_record|expire_time| The expire time for the SOA record. Defaults to `2419200`.|||False|
|soa_record|minimum_ttl| The minimum Time To Live for the SOA record. By convention, it is used to determine the negative caching duration. Defaults to `10`.|||False|
|soa_record|refresh_time| The refresh time for the SOA record. Defaults to `3600`.|||False|
|soa_record|retry_time| The retry time for the SOA record. Defaults to `300`.|||False|
|soa_record|ttl| The Time To Live of the SOA Record in seconds. Defaults to `3600`.|||False|
|soa_record|tags| A mapping of tags to assign to the Record Set.|||False|

## Outputs
| Name | Description |
|------|-------------|
|id|The Private DNS Zone ID.|||
|fqdn|The fully qualified domain name of the Record Set.|||
|host_name|The domain name of the authoritative name server for the SOA record.|||
|serial_number|The serial number for the SOA record. |||
|number_of_record_sets|The current number of record sets in this Private DNS zone.|||
|max_number_of_record_sets|The maximum number of record sets that can be created in this Private DNS zone.|||
|max_number_of_virtual_network_links|The maximum number of virtual networks that can be linked to this Private DNS zone.|||
|max_number_of_virtual_network_links_with_registration|The maximum number of virtual networks that can be linked to this Private DNS zone with registration enabled.|||
