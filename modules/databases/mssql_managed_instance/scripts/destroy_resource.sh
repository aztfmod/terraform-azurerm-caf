#!/bin/bash

VIRTUAL_CLUSTER_ID=$(az sql virtual-cluster list --query "[?childResources[?contains(@, '${RESOURCE_IDS}')]].id | [0]" --out tsv)

az resource delete --ids ${RESOURCE_IDS} || true
az resource delete --ids ${VIRTUAL_CLUSTER_ID} || true