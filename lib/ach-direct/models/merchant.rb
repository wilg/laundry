module ACH
  module Direct

    class Merchant
      extend Savon::Model
      
      # Setup WSDL
      if ACH::Direct.sandboxed?
        document "https://ws.paymentsgateway.net/Service/v1/Merchant.wsdl"
      else
        document "https://sandbox.paymentsgateway.net/WS/Merchant.wsdl"
      end
      
    end

  end
end