#!/bin/bash

# Get the orders from Global Sign
orders=$(curl -sb -X POST https://system.globalsign.com/kb/ws/v1/GASService -H "Content-Type: text/xml;charset=UTF-8" -d "${SOAP_GET_ORDERS}")

function cancel_order {
  SOAP_CANCEL_ORDER=$(echo $SOAP_CANCEL_ORDER_TPL | sed "s/#{order}/${1}/g")
  curl -sb -X POST https://system.globalsign.com/kb/ws/v2/ManagedSSLService -H "Content-Type: text/xml;charset=UTF-8" -d "${SOAP_CANCEL_ORDER}"
}

# Get the orders that have not been canceled (OrderStatus=5 for canceled-issued and 3 canceled-non-issued)
orderIDs=$(echo ${orders} | xq -r '."soap:Envelope"."soap:Body"."ns2:GetCertificateOrdersResponse".Response.SearchOrderDetails.SearchOrderDetail | if type == "array" then .[] else . end | select( .OrderStatus != "3" and .OrderStatus != "5") | .OrderID' 2>/dev/null)

if [[ ! -z "${orderIDs}" ]]; then

  # Process the order cancellation
  for orderID in ${orderIDs}; do
    echo "Cancelling orderID: ${orderID}"
    cancel_order ${orderID}
  done
else
  echo "No order to cancel"
fi
