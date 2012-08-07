module PaymentsGateway
  
  class TransactionResponse
  
    def initialize(response_data)      
      @data = {}
        
      parse(response_data) unless response_data.nil?
      setup_fields
            
      nil
    end
    
    def to_pg_hash
      @data
    end
    
    def success?
      self.pg_response_type == 'A'
    end
    
    private
    
    def parse(response_data)
      res = response_data.split("\n")
      res.each do |key_value_pair|
        kv = key_value_pair.split('=')
        if kv.size == 2
          @data[ kv[0] ] = kv[1]
        end
      end
    end
    
    def setup_fields
      @data.each do |key, value|                     
        self.class.send(:define_method, key) do
          @data[key]
        end
      end
    end

  end
  
end
