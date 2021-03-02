<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v2="https://system.globalsign.com/kb/ws/v2/">
  <soapenv:Header/>
  <soapenv:Body>
    <v2:ModifyMSSLOrder>
        <Request>
          <OrderRequestHeader>
              <AuthToken>
                <UserName>${UserName}</UserName>
                <Password>${Password}</Password>
              </AuthToken>
          </OrderRequestHeader>
          <OrderID>#{order}</OrderID>
          <ModifyOrderOperation>CANCEL</ModifyOrderOperation>
        </Request>
    </v2:ModifyMSSLOrder>
  </soapenv:Body>
</soapenv:Envelope>