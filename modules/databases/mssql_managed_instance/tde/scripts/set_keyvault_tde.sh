#!/bin/bash

az sql mi tde-key set --server-key-type AzureKeyVault --mi ${MI_NAME} -g ${RG_NAME} -k ${KEY_ID}
echo "${KEY_ID} set as ${MI_NAME} TDE-key"

