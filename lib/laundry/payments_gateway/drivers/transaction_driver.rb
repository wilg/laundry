module Laundry
  module PaymentsGateway

    class TransactionDriver < MerchantAuthenticatableDriver
    
      # Setup WSDL
      if Laundry.sandboxed?
        document 'https://sandbox.paymentsgateway.net/WS/Transaction.wsdl'
      else
        document 'https://ws.paymentsgateway.net/Service/v1/Transaction.wsdl'
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
