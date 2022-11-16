#!/bin/bash

set -e

function subscription_billing_role_assignment {

    echo "Set billing role assignment:"
    echo " - properties:"
    echo "${PROPERTIES}" | jq -r
    echo " - url: ${URL}"

    az rest --method PUT --url ${URL} --header Content-Type=application/json --body "${PROPERTIES}"

}


case "${METHOD}" in
    PUT)
        subscription_billing_role_assignment
        echo "Billing role assignment set."
        ;;
    DELETE)
        az rest --method DELETE --url ${URL}
        echo "Billing role assignment removed."
        ;;
esac
