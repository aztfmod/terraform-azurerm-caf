#!/bin/bash

set -e

function MG_Subscription {
    # https://docs.microsoft.com/en-us/rest/api/resources/tags/createorupdateatscope

    echo "${METHOD} Management Group ${MG_ID} - subscription: ${SUBSCRIPTION_ID}"

    microsoft_resource_endpoint=$(az cloud show | jq -r ".endpoints.resourceManager")

    URI="${microsoft_resource_endpoint}providers/Microsoft.Management/managementGroups/${MG_ID}/subscriptions/${SUBSCRIPTION_ID}?api-version=2020-02-01"

    az rest --method ${METHOD} --uri $URI

}


case "${METHOD}" in
    PUT)
        MG_Subscription
        echo "Subscription assigned to Management Group."
        ;;
    DELETE)
        MG_Subscription
        echo "Subscription removed from Management Group."
        ;;
esac



