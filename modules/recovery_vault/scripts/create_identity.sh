#!/bin/sh

set -e

function enable_directory_role {
    
    echo "Enabling identity: ${ARS_IDENTITY}"
    ROLE_ID=$(az rest --method PUT --uri https://management.azure.com/subscriptions/51345cde-fe67-4324-8ad8-079a30e33e51/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}?api-version=2016-06-01 -o json | jq -r '.value[] | select(.displayName == "'"$(echo ${ARS_IDENTITY})"'") | .id')

    URI="https://graph.microsoft.com/v1.0/directoryRoles"

    JSON=$( jq -n \
                --arg role_id ${ROLE_ID} \
            '{"identity": $role_id}' ) && echo " - body: $JSON"


    az rest --method POST --uri $URI --header Content-Type=application/json --body "$JSON"

}

echo "ARS identity '${ARS_IDENTITY}'"


# Add service principal to AD Role

export ROLE_AAD=$(az rest --method Get --uri https://graph.microsoft.com/v1.0/directoryRoles -o json | jq -r '.value[] | select(.displayName == "'"$(echo ${AD_ROLE_NAME})"'") | .id')

if [ "${ROLE_AAD}" == '' ]; then
    enable_directory_role
    export ROLE_AAD=$(az rest --method Get --uri https://graph.microsoft.com/v1.0/directoryRoles -o json | jq -r '.value[] | select(.displayName == "'"$(echo ${AD_ROLE_NAME})"'") | .id')
fi


case "${METHOD}" in
    POST)
        URI=$(echo  "https://graph.microsoft.com/v1.0/directoryRoles/${ROLE_AAD}/members/\$ref") && echo " - uri: $URI"

        # grant AAD role to the AAD APP
        JSON=$( jq -n \
            --arg uri_role "https://graph.microsoft.com/v1.0/directoryObjects/${SERVICE_PRINCIPAL_OBJECT_ID}" \
            '{"@odata.id": $uri_role}' ) && echo " - body: $JSON"

        az rest --method ${METHOD} --uri $URI --header Content-Type=application/json --body "$JSON"

        echo "Role '${AD_ROLE_NAME}' assigned to azure ad application"
        ;;
    DELETE)
        URI=$(echo  "https://graph.microsoft.com/v1.0/directoryRoles/${ROLE_AAD}/members/${SERVICE_PRINCIPAL_OBJECT_ID}/\$ref") && echo " - uri: $URI"
        az rest --method ${METHOD} --uri ${URI}
        echo "Role '${AD_ROLE_NAME}' unassigned to azure ad application ${SERVICE_PRINCIPAL_OBJECT_ID}"
        ;;
esac