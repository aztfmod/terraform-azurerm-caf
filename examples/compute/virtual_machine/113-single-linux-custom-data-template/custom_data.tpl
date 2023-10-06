
my_value=${my_value}

# palo_alto_connection_string example
storage-account=${storage_accounts["sa1"].name}, 
access-key=${storage_accounts["sa1"].primary_access_key},
file-share=${storage_accounts["sa1"].file_share["share1"].name}, 
share-directory=${storage_accounts["sa1"].file_share["share1"].file_share_directories["dir1"].name}

###### PUBLIC KEY ########
${keyvault_keys["key1"].public_key_pem}

vnet_address_space=${vnets["vnet_region1"].address_space[0]}