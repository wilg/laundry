module PaymentsGateway
  
  class Authentication
  
    def initialize(api_login_id, secure_transaction_key)
      @api_login_id = api_login_id
      @secure_transaction_key = secure_transaction_key
    end
    
    def login_hash
      # Time diff from 1/1/0001 00:00:00 to 1/1/1970 00:00:00
      utc_time = (DateTime.now.to_i + 62135596800).to_s + '0000000'
      
      ts_hash = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('md5'), @secure_transaction_key, "#{@api_login_id}|#{utc_time}")
      
      {:APILoginID => @api_login_id, :TSHash => ts_hash, :UTCTime => utc_time}
    end
    
  end
  
end
    