module Laundry
  module PaymentsGateway

    class MerchantAuthenticatableDriver
      extend Laundry::SOAPModel

      attr_accessor :merchant

      def initialize(merchant)
        # Save the merchant.
        self.merchant = merchant
        setup_client!
      end

      def setup_client!
        self.class.client.wsdl.document = self.class.wsdl if self.class.respond_to?(:wsdl)
      end

      def default_body
        # Log in via the merchant's login credentials.
        self.merchant.login_credentials.merge("MerchantID" => self.merchant.id)
      end

      def self.prettifiable_fields
        []
      end

      def self.uglify_hash(hash)
        translation = {}
        self.prettifiable_fields.each do |f|
          translation[f.snakecase.to_sym] = f
        end
        ugly_hash = {}
        hash.each do |k, v|
          if translation.has_key?(k)
            ugly_hash[translation[k]] = v
          else
            ugly_hash[k] = v
          end
        end
        ugly_hash
      end

    end

  end
end