module Laundry
  module PaymentsGateway

    class Transaction < ResponseModel
    
      def record
        response[:get_transaction_response][:get_transaction_result]
      end
      
      def status
        record[:response][:status].downcase
      end
    
    end

  end
end