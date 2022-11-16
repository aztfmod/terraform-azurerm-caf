#!/bin/bash
echo "removing all versions of image-definition ${IMAGE_NAME} in gallery ${GALLERY_NAME} in resource group ${RESOURCE_GROUP_NAME}"
az sig image-version list --resource-group ${RESOURCE_GROUP_NAME} --gallery-name ${GALLERY_NAME} --gallery-image-definition ${IMAGE_NAME} -o tsv --query 'sort_by([].{name:name},&name)' | xargs -I '{}' az sig image-version delete --resource-group ${RESOURCE_GROUP_NAME} --gallery-name ${GALLERY_NAME} --gallery-image-definition ${IMAGE_NAME} --gallery-image-version '{}' ||true
echo "sleeping a minute to propagate"
sleep 60
