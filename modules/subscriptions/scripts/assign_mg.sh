#!/bin/bash

set -e

function subscription_tag {
    # https://docs.microsoft.com/en-us/rest/api/resources/tags/createorupdateatscope

    echo "Set tags to subscription: ${SUBSCRIPTION_ID}"
    echo " - tags:"
    echo "${TAGS}" | jq -r
    URI="https://management.azure.com/subscriptions/${SUBSCRIPTION_ID}/providers/Microsoft.Resources/tags/default?api-version=2020-06-01"

    az rest --method PUT --uri $URI --header Content-Type=application/json --body "${TAGS}"

}


case "${METHOD}" in
    PUT)
        subscription_tag
        echo "Tags updated on the subscription."
        ;;
esac



