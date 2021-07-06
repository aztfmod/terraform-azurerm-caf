#!/bin/bash

set -e

microsoft_graph_endpoint=$(az cloud show | jq -r ".endpoints.microsoftGraphResourceId")

function enable_directory_role {
    # Verify the AD_ROLE_NAME has been activated in the directory
    # Permissions required - https://docs.microsoft.com/en-us/graph/api/directoryrole-post-directoryroles?view=graph-rest-1.0&tabs=http#permissions

    echo "Enabling directory role: ${AD_ROLE_NAME}"
    ROLE_ID=$(az rest --method Get --uri ${microsoft_graph_endpoint}v1.0/directoryRoleTemplates -o json | jq -r '.value[] | select(.displayName == "'"$(echo ${AD_ROLE_NAME})"'") | .id')

    URI="${microsoft_graph_endpoint}v1.0/directoryRoles"

    JSON=$( jq -n \
                --arg role_id ${ROLE_ID} \
            '{"roleTemplateId": $role_id}' ) && echo " - body: $JSON"


    az rest --method POST --uri $URI --header Content-Type=application/json --body "$JSON"

}

echo "Directory role '${AD_ROLE_NAME}'"


# Add service principal to AD Role

export ROLE_AAD=$(az rest --method Get --uri ${microsoft_graph_endpoint}v1.0/directoryRoles -o json | jq -r '.value[] | select(.displayName == "'"$(echo ${AD_ROLE_NAME})"'") | .id')

if [ "${ROLE_AAD}" == '' ]; then
    enable_directory_role
    export ROLE_AAD=$(az rest --method Get --uri ${microsoft_graph_endpoint}v1.0/directoryRoles -o json | jq -r '.value[] | select(.displayName == "'"$(echo ${AD_ROLE_NAME})"'") | .id')
fi


case "${METHOD}" in
    POST)
        URI=$(echo  "${microsoft_graph_endpoint}v1.0/directoryRoles/${ROLE_AAD}/members/\$ref") && echo " - uri: $URI"

        # grant AAD role to the AAD APP
        JSON=$( jq -n \
            --arg uri_role "${microsoft_graph_endpoint}v1.0/directoryObjects/${SERVICE_PRINCIPAL_OBJECT_ID}" \
            '{"@odata.id": $uri_role}' ) && echo " - body: $JSON"

        az rest --method ${METHOD} --uri $URI --header Content-Type=application/json --body "$JSON"

        echo "Role '${AD_ROLE_NAME}' assigned to azure ad principal"
        ;;
    DELETE)
        URI=$(echo  "${microsoft_graph_endpoint}v1.0/directoryRoles/${ROLE_AAD}/members/${SERVICE_PRINCIPAL_OBJECT_ID}/\$ref") && echo " - uri: $URI"
        az rest --method ${METHOD} --uri ${URI} || true
        echo "Role '${AD_ROLE_NAME}' unassigned to azure ad principal ${SERVICE_PRINCIPAL_OBJECT_ID}"
        ;;
esac



