module ACH
  module Direct

    class Merchant
      extend ACH::Direct::SOAPModel
      
      # Setup WSDL
      if ACH::Direct.sandboxed?
        document "https://sandbox.paymentsgateway.net/WS/Merchant.wsdl"
      else
        document "https://ws.paymentsgateway.net/Service/v1/Merchant.wsdl"
      end
      
    end

  end
end