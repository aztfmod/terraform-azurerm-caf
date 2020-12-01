#!/bin/bash

az sql mi ad-admin delete --mi ${MI_NAME} -g ${RG_NAME}
echo "'Unassigned ${MI_NAME} admin"