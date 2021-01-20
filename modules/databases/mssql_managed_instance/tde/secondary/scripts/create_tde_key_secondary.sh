#!/bin/bash

az keyvault key backup --file ./temp_backup.keybackup --id ${PRIMARY_KEY_ID}
echo "backup of ${PRIMARY_KEY_ID} saved to ./temp_backup.keybackup"

az keyvault key restore --file ./temp_backup.keybackup --vault-name ${KEYVAULT_NAME}
echo "Primary TDE Key restored to ${KEYVAULT_NAME}"

rm ./temp_backup.keybackup
echo "Removed backup from local"