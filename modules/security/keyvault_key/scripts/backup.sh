#!/bin/bash
rm ./temp_backup.keybackup
az keyvault key backup --file ./temp_backup.keybackup --id ${PRIMARY_KEY_ID}
echo "backup of ${PRIMARY_KEY_ID} saved to ./temp_backup.keybackup"

