#!/bin/bash

set -e

resourceId=$(az ad sp show --id "${resourceAppId}" --query "objectId" -o tsv)
echo " -resourceId: ${resourceId}"

URI=$(echo  "https://graph.microsoft.com/beta/servicePrincipals/${resourceId}/appRoleAssignments") && echo " - uri: $URI"

# grant consent (Application.ReadWrite.OwnedBy)
JSON=$( jq -n \
            --arg principalId "${principalId}" \
            --arg resourceId "${resourceId}" \
            --arg appRoleId "${appRoleId}" \
        '{principalId: $principalId, resourceId: $resourceId, appRoleId: $appRoleId}' ) && echo " - body: $JSON"

az rest --method POST --uri $URI --header Content-Type=application/json --body "$JSON"
