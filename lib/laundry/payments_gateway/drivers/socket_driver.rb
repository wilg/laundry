module Laundry
  module PaymentsGateway

    class SocketDriver < MerchantAuthenticatableDriver

      # Setup WSDL
      def self.wsdl
        if Laundry.sandboxed?
          "https://ws.paymentsgateway.net/pgtest/paymentsgateway.asmx?WSDL"
        else
          "https://ws.paymentsgateway.net/pg/paymentsgateway.asmx?WSDL"
        end
      end

      actions "ExecuteSocketQuery"

      def exec(options = {})
        execute_socket_query(options) do
          http.headers["SOAPAction"] = "http://paymentsgateway.achdirect.com/ExecuteSocketQuery"
        end
      end

    end

  end
end
