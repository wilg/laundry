module Laundry
  module PaymentsGateway

    class TransactionResponse < ResponseModel
      
      attr_accessor :response_record
      
      def initialize(response, merchant)
        super
        parse
      end
      
      def record
        self.response_record
      end
      
      def success?
        pg_response_type == 'A'
      end
      
      def full_transaction
        self.merchant.transactions.find pg_payment_method_id, pg_trace_number
      end
            
      private
        
      def parse
        data = {}
        res = self.response[:execute_socket_query_response][:execute_socket_query_result].split("\n")
        res.each do |key_value_pair|
          kv = key_value_pair.split('=')
          if kv.size == 2
            data[ kv[0].to_sym ] = kv[1]
          end
        end
        self.response_record = data
      end
      
    end

  end
end