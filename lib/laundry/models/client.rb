module Laundry

  class Client < Laundry::MerchantAuthenticatableModel
    
   # Setup WSDL
    # if ACH::Direct.sandboxed?
    document "https://sandbox.paymentsgateway.net/WS/Client.wsdl"
    #   # endpoint 'https://sandbox.paymentsgateway.net/WS/Client.svc'
    #   # namespace 'https://ws.paymentsgateway.net/v1'
    # else
    #   document "https://ws.paymentsgateway.net/Service/v1/Client.wsdl"
    # end
    
    actions "createClient", "getClient"
    
    def get_client(id)
      super({'MerchantID' => self.merchant.id, 'ClientID' => id}) do
        http.headers["SOAPAction"] = 'https://ws.paymentsgateway.net/v1/IClientService/getClient'
      end 
    end
    
  end

end
