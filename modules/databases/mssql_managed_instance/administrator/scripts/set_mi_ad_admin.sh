#!/bin/bash

az sql mi ad-admin create -u ${DISPLAY_NAME} --mi ${MI_NAME} -i ${OBJECT_ID} -g ${RG_NAME}
echo "${DISPLAY_NAME} assigned as ${MI_NAME} admin"

# case "${METHOD}" in
#     POST)       
#         az sql mi ad-admin create -u ${DISPLAY_NAME} --mi ${MI_NAME} -i ${OBJECT_ID} -g ${RG_NAME}

#         echo "${DISPLAY_NAME} assigned as ${MI_NAME} admin"
#         ;;
#     DELETE)
#         az sql mi ad-admin delete --mi ${MI_NAME} -g ${RG_NAME}
#         echo "'Unassigned ${MI_NAME} admin"
#         ;;
# esac