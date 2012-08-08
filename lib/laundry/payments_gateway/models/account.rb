module Laundry
  module PaymentsGateway

    class Account < ResponseModel
      
      def record
        response[:get_payment_method_response][:get_payment_method_result][:payment_method]
      end
      
      # EFT TRANSACTION_CODES
      EFT_SALE = 20
      EFT_AUTH_ONLY = 21
      EFT_CAPTURE = 22
      EFT_CREDIT = 23
      EFT_VOID = 24
      EFT_FORCE = 25
      EFT_VERIFY_ONLY = 26
      
      def debit_cents(cents, *args)
        debit_dollars(dollarize(cents), *args)
      end

      def credit_cents(cents, *args)
        credit_dollars(dollarize(cents), *args)
      end
      
      def debit_dollars(dollars, *args)
        perform_transaction(dollars, EFT_SALE, *args)
      end
      
      def credit_dollars(dollars, *args)
        perform_transaction(dollars, EFT_CREDIT, *args)
      end
      
      def perform_transaction(dollars, type, options = {})
        options = {
         'pg_merchant_id' => self.merchant.id, 
         'pg_password' => self.merchant.transaction_password,       
         'pg_total_amount' => dollars,
         'pg_client_id' => self.client_id,
         'pg_payment_method_id' => self.id,
         'pg_transaction_type' => type
         }.merge(options)
        r = self.merchant.socket_driver.exec(options)
        TransactionResponse.new(r, self.merchant)
      end
            
      def id
        payment_method_id
      end
      
      private
      
      def dollarize(cents)
        cents.to_f / 100.0
      end

    end

  end
end
