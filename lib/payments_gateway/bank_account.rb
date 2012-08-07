module PaymentsGateway
  
  class BankAccount
    
    CHECKING = 'CHECKING'
    SAVINGS = 'SAVINGS'
    
    YES = 'true'
    NO = 'false'
    
    #EFT TRANSACTION_CODES
    EFT_SALE = 20
    EFT_AUTH_ONLY = 21
    EFT_CAPTURE = 22
    EFT_CREDIT = 23
    EFT_VOID = 24
    EFT_FORCE = 25
    EFT_VERIFY_ONLY = 26
  
  
    def initialize(account = nil, transaction_password = nil)        
      @field_map = {}
      @data = {}
      @transaction_password = transaction_password
      
      setup_fields
      parse(account) unless account.nil?

      nil
    end
    
    
    def debit_setup(amount)
      {:pg_merchant_id => self.merchant_id, 
       :pg_password => @transaction_password,       
       :pg_transaction_type => EFT_SALE,
       :pg_total_amount => amount,
       :pg_client_id => self.client_id,
       :pg_payment_method_id => self.payment_method_id,
       :pg_merchant_data_1 => 'just a test'}
    end
    
    
    def credit_setup(amount)
      {:pg_merchant_id => self.merchant_id, 
       :pg_password => @transaction_password,       
       :pg_transaction_type => EFT_CREDIT,
       :pg_total_amount => amount,
       :pg_client_id => self.client_id,
       :pg_payment_method_id => self.payment_method_id,
       :pg_merchant_data_1 => 'just a test'}
    end
    
    
    def to_pg_hash
      retval = {}
      @data.each { |key, value| retval[ @field_map[key] ] = value }
      return retval
    end
    
    private
    
    def setup_fields
      pg_fields  = ['MerchantID',
                    'ClientID',
                    'PaymentMethodID',
                    'AcctHolderName',
                    'EcAccountNumber',
                    'EcAccountTRN',
                    'EcAccountType',
                    'Note',
                    'IsDefault']
      
      pg_fields.each do |field|             
        m_name = field.underscore 
        @field_map[m_name] = field
        @data[m_name] = ''
        
        self.class.send(:define_method, m_name) do
          @data[m_name]
        end
        
        self.class.send(:define_method, "#{m_name}=") do |val|
          @data[m_name] = val
        end
      end          
    end
    
    def parse(account)
      account.__xmlele.each do |x| x.first.name 
        m_name = x.first.name.underscore 
        if @field_map[m_name]                
          # client_record[x.first.name] will contain the value "SOAP::Mapping::Object" if it is blank.
          @data[m_name] = account[x.first.name].class.to_s == "SOAP::Mapping::Object" ? '' : account[x.first.name]
        end
      end
    end

  end
  
end
