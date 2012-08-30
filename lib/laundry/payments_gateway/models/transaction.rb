module Laundry
  module PaymentsGateway

    class Transaction < ResponseModel

      def initialize_with_response(response)
        self.record = response[:get_transaction_response][:get_transaction_result]
      end

      def status
        record[:response][:status].downcase
      end

    end

  end
end