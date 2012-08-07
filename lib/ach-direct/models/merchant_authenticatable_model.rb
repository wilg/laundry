module ACH
  module Direct

    class MerchantAuthenticatableModel
      extend ACH::Direct::SOAPModel
      # 
      # namespace "goddamn"
      # client.wsdl.namespace     # => "http://v1.example.com"
      # 
      # # the SOAP endpoint
      # client.wsdl.endpoint      # => "http://service.example.com"
      # 
      # Savon.configure do |c|
      #   c.env_namespace = :soapenv
      # end
      
      # client do
      #   # xml.env_namespace = :soap
      #   # wsdl.document = "https://portal.x-mobility.com/services/MobileServices?wsdl"
      #   # wsdl.endpoint = "https://portal.x-mobility.com/services/MobileServices"
      #   # wsdl.element_form_default = :unqualified
      #   # wsse.credentials "XXXX", "XXXX"
      # end
      
      attr_accessor :merchant
      
      def initialize(merchant)
        # Save the merchant.
        self.merchant = merchant
        
        # Log in via the merchant's login credentials.
        default_body self.merchant.login_credentials
      end
      
    end

  end
end