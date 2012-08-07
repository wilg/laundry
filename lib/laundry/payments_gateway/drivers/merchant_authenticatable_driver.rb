module Laundry
  module PaymentsGateway

    class MerchantAuthenticatableDriver
      extend Laundry::SOAPModel
    
      attr_accessor :merchant
    
      def initialize(merchant)
        # Save the merchant.
        self.merchant = merchant
      
        # Log in via the merchant's login credentials.
        default_body self.merchant.login_credentials.merge("MerchantID" => self.merchant.id)
      end
          
    end
    
  end
end