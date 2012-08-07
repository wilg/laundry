module Laundry
  module PaymentsGateway

    class Client < MerchantAuthenticatableModel
    
     # Setup WSDL
      if Laundry.sandboxed?
        document "https://sandbox.paymentsgateway.net/WS/Client.wsdl"
      else
        document "https://ws.paymentsgateway.net/Service/v1/Client.wsdl"
      end
    
      actions "createClient", "getClient"
    
      def get_client(id)
        super({'MerchantID' => self.merchant.id, 'ClientID' => id}) do
          http.headers["SOAPAction"] = 'https://ws.paymentsgateway.net/v1/IClientService/getClient'
        end 
      end
    
    end

  end
end
