module Laundry
  module PaymentsGateway

    class Client < ResponseModel
      
      def record
        response[:get_client_response][:get_client_result][:client_record]
      end

      def id
        record[:client_id]
      end
      
      def accounts_driver
        AccountDriver.new(self.id, self.merchant)
      end
      alias_method :accounts, :accounts_driver
      
      def method_missing(id, *args)
        return record[id.to_sym] if record.has_key? id.to_sym
        raise NoMethodError
      end

    end

  end
end