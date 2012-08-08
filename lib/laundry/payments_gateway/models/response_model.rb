module Laundry
  module PaymentsGateway

    class ResponseModel

      attr_accessor :response
      attr_accessor :merchant
      def initialize(response, merchant)
        self.response = response
        self.merchant = merchant
      end
      
      # Override please.
      def record
        response || {}
      end
      
      def to_hash
        record
      end
      
      def method_missing(id, *args)
        return record[id.to_sym] if record.has_key? id.to_sym
        super
      end
        
    end

  end
end