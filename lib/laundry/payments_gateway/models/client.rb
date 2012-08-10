module Laundry
  module PaymentsGateway

    class Client < ResponseModel
      
      def initialize_with_response(response)
        self.record = response[:get_client_response][:get_client_result][:client_record]
      end

      def id
        client_id
      end
      
      def accounts_driver
        require_merchant!
        AccountDriver.new(self, self.merchant)
      end
      alias_method :accounts, :accounts_driver
      
    end

  end
end