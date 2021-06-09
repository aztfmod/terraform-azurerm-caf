#!/bin/bash

set -e


user_type=$(az account show --query user.type -o tsv)

if [ "${user_type}" = "user" ]; then

    az ad app permission admin-consent --id ${applicationId}

else

    resourceId=$(az ad sp show --id "${resourceAppId}" --query "objectId" -o tsv)
    echo " -resourceId: ${resourceId}"

    microsoft_graph_endpoint=$(az cloud show | jq -r ".endpoints.microsoftGraphResourceId")

    URI=$(echo  "${microsoft_graph_endpoint}beta/servicePrincipals/${resourceId}/appRoleAssignments") && echo " - uri: $URI"

    # grant consent (Application.ReadWrite.OwnedBy)
    JSON=$( jq -n \
                --arg principalId "${principalId}" \
                --arg resourceId "${resourceId}" \
                --arg appRoleId "${appRoleId}" \
            '{principalId: $principalId, resourceId: $resourceId, appRoleId: $appRoleId}' ) && echo " - body: $JSON"

    az rest --method POST --uri $URI --header Content-Type=application/json --body "$JSON"

fi
