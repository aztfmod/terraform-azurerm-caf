#!/bin/bash

set -e

function get_admin_grant(){
    local resourceId=$1
    local principalId=$2
    local appRoleId=$3

    local microsoft_graph_endpoint=$(az cloud show | jq -r ".endpoints.microsoftGraphResourceId")

    local URI="${microsoft_graph_endpoint}beta/servicePrincipals/${principalId}/appRoleAssignments"

    local RESULT=$(az rest --method GET --uri $URI --header Content-Type=application/json --query "value" | jq -r --arg APPROLEID "$appRoleId" --arg RESOURCEID "$resourceId" '.[] | select (.appRoleId==$APPROLEID) | select(.resourceId==$RESOURCEID)')
  
    echo $RESULT
}

user_type=$(az account show --query user.type -o tsv)

if [ "${user_type}" = "user" ]; then
    az ad app permission admin-consent --id ${applicationId}
else
    resourceId=$(az ad sp show --id "${resourceAppId}" --query "objectId" -o tsv)
    echo "ResourceAppId:${resourceAppId}"
    echo "PrincipalId:${principalId}"
    echo "AppRoleId:${appRoleId}"  
        
    if [[ -z $(get_admin_grant ${resourceId} ${principalId} ${appRoleId}) ]]; then
        echo "resourceId: ${resourceId}"
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
fi