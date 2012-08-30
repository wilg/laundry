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
        r = client_driver.get_payment_method({'ClientID' => self.client.id, 'PaymentMethodID' => payment_method_id}) do
          http.headers["SOAPAction"] = 'https://ws.paymentsgateway.net/v1/IClientService/getPaymentMethod'
        end
        Account.from_response(r, self.merchant)
      end

      # Returns the payment method id
      def create!(options = {})
        raise ArgumentError, "Tried to create an account on an invalid client." if self.client.nil? || self.client.blank?
        options = {merchant_id: self.merchant.id, client_id: self.client.id, payment_method_id: 0}.merge(options)
        options = AccountDriver.uglify_hash(options)
        r = client_driver.create_payment_method({'payment' => options}) do
          http.headers["SOAPAction"] = 'https://ws.paymentsgateway.net/v1/IClientService/createPaymentMethod'
        end
        r[:create_payment_method_response][:create_payment_method_result]
      end

      def self.prettifiable_fields
        ['MerchantID',
         'ClientID',
         'PaymentMethodID',
         'AcctHolderName',
         'EcAccountNumber',
         'EcAccountTRN',
         'EcAccountType',
         'Note',
         'IsDefault']
      end

    end

  end
end
