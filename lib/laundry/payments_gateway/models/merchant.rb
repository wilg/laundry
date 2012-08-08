module Laundry
  module PaymentsGateway

    class Merchant
      extend Laundry::SOAPModel
    
      # Setup WSDL
      if Laundry.sandboxed?
        document "https://sandbox.paymentsgateway.net/WS/Merchant.wsdl"
      else
        document "https://ws.paymentsgateway.net/Service/v1/Merchant.wsdl"
      end
      
      def self.default_merchant(options = nil)
        @@default_merchant = Merchant.new(options) if options
        @@default_merchant
      end
    
      attr_accessor :id, :api_login_id, :api_password, :transaction_password
    
      def initialize(options = {})
      
        self.id = options[:id]
        self.api_login_id = options[:api_login_id]
        self.api_password = options[:api_password]
        self.transaction_password = options[:transaction_password]
              
      end
          
      def client_driver
        @client_driver ||= ClientDriver.new(self)
      end
      alias_method :clients, :client_driver
    
      def transaction_driver
        @transaction_driver ||= TransactionDriver.new(self)
      end
      alias_method :transactions, :transaction_driver
    
      def socket_driver
        @socket_driver ||= SocketDriver.new(self)
      end
    
      def login_credentials
        # Time diff from 1/1/0001 00:00:00 to 1/1/1970 00:00:00
        utc_time = (Time.now.to_i + 62135596800).to_s + '0000000'
        ts_hash = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('md5'), self.api_password, "#{self.api_login_id}|#{utc_time}")
        {'ticket' => {'APILoginID' => self.api_login_id, 'TSHash' => ts_hash, 'UTCTime' => utc_time}}
      end
    
    end

  end
end