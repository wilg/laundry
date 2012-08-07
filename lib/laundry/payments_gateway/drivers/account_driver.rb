module Laundry
  module PaymentsGateway

    class AccountDriver < MerchantAuthenticatableDriver
      
      attr_accessor :client
      def initialize(client, merchant)
        super merchant
        self.client = client
      end
    
      def client_driver
        @client_driver ||= ClientDriver.new(self.merchant)
      end
      
      def find(payment_method_id)
        client_driver.get_payment_method({'ClientID' => self.client.id, 'PaymentMethodID' => payment_method_id}) do
          http.headers["SOAPAction"] = 'https://ws.paymentsgateway.net/v1/IClientService/getPaymentMethod'
        end
      end
      
      def create!(options = {})
        r = client_driver.create_payment_method({'client' => {'MerchantID' => self.merchant.id, 'PaymentMethodID' => 0}.merge(options)} ) do
          http.headers["SOAPAction"] = 'https://ws.paymentsgateway.net/v1/IClientService/createPaymentMethod'
        end
        r
      end
    
    end
  
  end
end
