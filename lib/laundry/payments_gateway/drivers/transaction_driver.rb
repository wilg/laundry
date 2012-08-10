module Laundry
  module PaymentsGateway

    class TransactionDriver < MerchantAuthenticatableDriver
    
      # Setup WSDL
      def self.wsdl
        if Laundry.sandboxed?
          'https://sandbox.paymentsgateway.net/WS/Transaction.wsdl'
        else
          'https://ws.paymentsgateway.net/Service/v1/Transaction.wsdl'
        end
      end
    
      actions "getTransaction"
      
      def find(client_id, transaction_id)
        r = get_transaction({'ClientID' => client_id, 'TransactionID' => transaction_id}) do
          http.headers["SOAPAction"] = "https://ws.paymentsgateway.net/v1/ITransactionService/getTransaction"
        end
        Transaction.from_response(r, self.merchant)
      end

    end

  end
end
