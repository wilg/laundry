module Laundry
  module PaymentsGateway

    class Client < ResponseModel
      
      def record
        response[:get_client_response][:get_client_result][:client_record]
      end

      def id
        client_id
      end
      
      def accounts_driver
        AccountDriver.new(self, self.merchant)
      end
      alias_method :accounts, :accounts_driver
      
    end

  end
end