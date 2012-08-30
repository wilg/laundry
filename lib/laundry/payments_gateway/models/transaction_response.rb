module Laundry
  module PaymentsGateway

    class TransactionResponse < ResponseModel

      def initialize_with_response(response)
        self.record = parse(response)
      end

      def success?
        pg_response_type == 'A'
      end

      def full_transaction
        require_merchant!
        self.merchant.transactions.find pg_payment_method_id, pg_trace_number
      end

      private

      def parse(response)
        data = {}
        res = response[:execute_socket_query_response][:execute_socket_query_result].split("\n")
        res.each do |key_value_pair|
          kv = key_value_pair.split('=')
          if kv.size == 2
            data[ kv[0].to_sym ] = kv[1]
          end
        end
        data
      end

    end

  end
end