module Laundry
  module PaymentsGateway

    class MerchantAuthenticatableModel
      extend Laundry::SOAPModel
    
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