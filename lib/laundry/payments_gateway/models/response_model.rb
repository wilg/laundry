module Laundry
  module PaymentsGateway

    class ResponseModel

      attr_accessor :response
      attr_accessor :merchant
      def initialize(response, merchant)
        self.response = response
        self.merchant = merchant
      end
      
    end

  end
end