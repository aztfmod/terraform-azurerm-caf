#!/bin/sh

set -e

case "${METHOD}" in
    PATCH)
        echo " - uri: $URI"

        # Enable System Identity
        JSON=$( jq -n \
            '{"Identity": 
                {"type": "SystemAssigned"}
            }' ) && echo " - body: $JSON"

        az rest --method ${METHOD} --uri $URI --header Content-Type=application/json --body "$JSON"

        echo "System Identity enabled for the ASR vault."
        ;;
esac