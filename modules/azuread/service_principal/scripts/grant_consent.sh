#!/bin/bash

set -e

resourceId=$(az ad sp show --id "${resourceAppId}" --query "objectId" -o tsv)
echo " -resourceId: ${resourceId}"

microsoft_graph_endpoint=$(az cloud show | jq -r ".endpoints.microsoftGraphResourceId")

URI=$(echo  "${microsoft_graph_endpoint}v1.0/servicePrincipals/${resourceId}/appRoleAssignedTo") && echo " - uri: $URI"

appRoleId=$(az rest --method GET --uri ${URI} \
    --query "value[?appRoleId=='${appRoleId}' && principalId=='${principalId}' && resourceId=='${resourceId}'].appRoleId" -o tsv)

if [ -z ${appRoleId} ]; then
    JSON=$( jq -n \
                --arg principalId "${principalId}" \
                --arg resourceId "${resourceId}" \
                --arg appRoleId "${appRoleId}" \
            '{principalId: $principalId, resourceId: $resourceId, appRoleId: $appRoleId}' ) && echo " - body: $JSON"

    az rest --method POST --uri $URI --header Content-Type=application/json --body "$JSON"
else
    echo "API permission already granted."
fi