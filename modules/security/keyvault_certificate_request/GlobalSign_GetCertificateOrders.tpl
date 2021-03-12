<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:v1="https://system.globalsign.com/kb/ws/v1/">
   <soapenv:Header/>
   <soapenv:Body>
      <v1:GetCertificateOrders>
         <Request>
            <QueryRequestHeader>
               <AuthToken>
                  <UserName>${UserName}</UserName>
                  <Password>${Password}</Password>
               </AuthToken>
            </QueryRequestHeader>
            <FQDN>${FQDN}</FQDN>
         </Request>
      </v1:GetCertificateOrders>
   </soapenv:Body>
</soapenv:Envelope>
