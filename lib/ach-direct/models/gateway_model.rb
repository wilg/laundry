module ACH
  module Direct

    class GatewayModel
      extend ACH::Direct::SOAPModel
      
      def initialize(merchant)
        @merchant = merchant
      end
      
    end

  end
end