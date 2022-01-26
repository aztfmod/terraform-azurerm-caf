#!/bin/bash

set -e

function subscription_tags {
    # https://docs.microsoft.com/en-us/rest/api/resources/tags/createorupdateatscope

    echo "Set tags to subscription: ${SUBSCRIPTION_ID}"
    echo " - tags:"
    echo "${TAGS}" | jq -r

    microsoft_resource_endpoint=$(az cloud show | jq -r ".endpoints.resourceManager")

    URI="${microsoft_resource_endpoint}subscriptions/${SUBSCRIPTION_ID}/providers/Microsoft.Resources/tags/default?api-version=2020-06-01"
    echo " - uri: ${URI}"

    az rest --method PUT --uri $URI --header Content-Type=application/json --body "${TAGS}"

}


case "${METHOD}" in
    PUT)
        subscription_tags
        echo "Tags updated on the subscription."
        ;;
esac



