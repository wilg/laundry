module Laundry
  module PaymentsGateway

    class ClientDriver < MerchantAuthenticatableDriver
    
     # Setup WSDL
      if Laundry.sandboxed?
        document "https://sandbox.paymentsgateway.net/WS/Client.wsdl"
      else
        document "https://ws.paymentsgateway.net/Service/v1/Client.wsdl"
      end
    
      actions "createClient", "getClient"
    
      def find(id)
        get_client({'ClientID' => id}) do
          http.headers["SOAPAction"] = 'https://ws.paymentsgateway.net/v1/IClientService/getClient'
        end 
      end
      
      # Creates a client and returns the newly created client id.
      def create!(options = {})
        r = create_client({'client' => ClientDriver.default_hash.merge(options).merge({'MerchantID' => self.merchant.id, 'ClientID' => 0, 'Status' => 'Active'})} ) do
          http.headers["SOAPAction"] = 'https://ws.paymentsgateway.net/v1/IClientService/createClient'
        end
        r[:create_client_response][:create_client_result]
      end
      
      def self.default_fields
        ['MerchantID',
         'ClientID',
         'FirstName',
         'LastName',
         'CompanyName',
         'Address1',
         'Address2',
         'City',
         'State',
         'PostalCode',
         'CountryCode',
         'PhoneNumber',
         'FaxNumber',
         'EmailAddress',
         'ShiptoFirstName',
         'ShiptoLastName',
         'ShiptoCompanyName',
         'ShiptoAddress1',
         'ShiptoAddress2',
         'ShiptoCity',
         'ShiptoState',
         'ShiptoPostalCode',
         'ShiptoCountryCode',
         'ShiptoPhoneNumber',
         'ShiptoFaxNumber',
         'ConsumerID',
         'Status']
      end
      
      def self.default_hash
        h = {}
        self.default_fields.each do |f|
          h[f] = ""
        end
        h
      end
    
    end

  end
end
