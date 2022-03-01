#!/bin/bash

az sql mi tde-key set --server-key-type ServiceManaged --mi ${MI_NAME} -g ${RG_NAME}
echo "Set TDE-key for ${MI_NAME} to ServiceManaged"