module PaymentsGateway
  
  class MerchantAccount

    attr_accessor :client_driver
  
    def initialize(merchant_id, api_login_id, api_password, transaction_password, production = true)
      if production
        payments_gateway_client_wsdl = 'https://ws.paymentsgateway.net/Service/v1/Client.wsdl'
        payments_gateway_transaction_wsdl = 'https://ws.paymentsgateway.net/Service/v1/Transaction.wsdl'
        payments_gateway_merchant_wsdl = 'https://ws.paymentsgateway.net/Service/v1/Merchant.wsdl'        
        payments_gateway_socket_wsdl = 'https://ws.paymentsgateway.net/pg/paymentsgateway.asmx?WSDL'
      else
        payments_gateway_client_wsdl = 'https://sandbox.paymentsgateway.net/WS/Client.wsdl'
        payments_gateway_transaction_wsdl = 'https://sandbox.paymentsgateway.net/WS/Transaction.wsdl'
        payments_gateway_merchant_wsdl = 'https://sandbox.paymentsgateway.net/WS/Merchant.wsdl'        
        payments_gateway_socket_wsdl = 'https://ws.paymentsgateway.net/pgtest/paymentsgateway.asmx?WSDL'
      end
      
      @merchant_id = merchant_id
      @api_login_id = api_login_id
      @api_password = api_password
      @transaction_password = transaction_password

      @client_driver = SOAP::WSDLDriverFactory.new(payments_gateway_client_wsdl).create_rpc_driver
      @transaction_driver = SOAP::WSDLDriverFactory.new(payments_gateway_transaction_wsdl).create_rpc_driver
      @merchant_driver = SOAP::WSDLDriverFactory.new(payments_gateway_merchant_wsdl).create_rpc_driver
      @socket_driver = SOAP::WSDLDriverFactory.new(payments_gateway_socket_wsdl).create_rpc_driver
      nil
    end
  
    ###################################
    # Transaction
    ###################################
    
    def get_transaction(client_id, transaction_id)
      params = {:MerchantID => @merchant_id, :ClientID => client_id, :TransactionID => transaction_id}    
      response = @transaction_driver.getTransaction( login_credentials.merge(params) )      
    end

  
    ###################################
    # Client
    ###################################
    def get_clients
      raise 'get_clients method not implemented yet'
    end
    
    
    def get_client(client_id)
      params = {:MerchantID => @merchant_id, :ClientID => client_id}    
      response = @client_driver.getClient( login_credentials.merge(params) )      
      PaymentsGateway::Client.new( response.getClientResult['ClientRecord'] )
    end
    
    
    def create_client(client)
      params = {'client' => client.to_pg_hash.merge({'MerchantID' => @merchant_id, 'ClientID' => 0, 'Status' => 'Active'})} 

      begin
        response = @client_driver.createClient( login_credentials.merge(params) ) 
        response.createClientResult   
      rescue Exception => e
        raise e
        0
      end
    end
    
    
    def update_client(client)
      params = {'client' => client.to_pg_hash} 
      begin
        response = @client_driver.updateClient( login_credentials.merge(params) ) 
        response.updateClientResult.to_i == client_id.to_i ? true : false     
      rescue Exception => e
        raise e
        false
      end
    end
    
    
    def delete_client(client_id)
      params = {:ClientID => client_id, :MerchantID => @merchant_id}    
      begin
        response = @client_driver.deleteClient( login_credentials.merge(params) ) 
        response.deleteClientResult.to_i == client_id.to_i ? true : false     
      rescue Exception => e
        raise e
        false
      end
    end
    
    
    
    ###################################
    # Bank Account
    ###################################
    # def get_bank_accounts(client_id)
    #   params = {'ClientID' => client_id, 'PaymentMethodID' => 0}    
    #   response = @client_driver.getPaymentMethod( login_credentials.merge(params) ) 
    # 
    #   PaymentsGateway::Client.new( response.getPaymentMethodResult['PaymentMethod'] )
    # end    
    
    
    def get_bank_account(client_id, account_id)
      params = {'MerchantID' => @merchant_id, 'ClientID' => client_id, 'PaymentMethodID' => account_id}    
      puts "[MerchantAccount] id: #{@merchant_id}, client_driver: #{@client_driver}, params: #{login_credentials.merge(params).to_s}"
      response = @client_driver.getPaymentMethod( login_credentials.merge(params) ) 
      ba = PaymentsGateway::BankAccount.new( response.getPaymentMethodResult['PaymentMethod'], @transaction_password )
      return ba
    end
    
    
    def create_bank_account(bank_account)
      #other_fields = {'AcctHolderName' => '0', 'CcCardNumber' => '0', 'CcExpirationDate' => '0', 'CcCardType' => 'VISA'}
      other_fields = {'CcCardType' => 'VISA', 'CcProcurementCard' => 'false'}
      params = {'payment' => bank_account.to_pg_hash.merge({'MerchantID' => @merchant_id, 'PaymentMethodID' => 0}.merge(other_fields))} 
      begin
        response = @client_driver.createPaymentMethod( login_credentials.merge(params) ) 
        response.createPaymentMethodResult   
      rescue Exception => e
        raise e
      end
    end
    
    
    def update_bank_account
      raise 'update_bank_account method not implemented yet'
    end
    
    
    def delete_bank_account(payment_method_id)
      params = {'MerchantID' => @merchant_id, 'PaymentMethodID' => payment_method_id}
      begin         
        response = @client_driver.deletePaymentMethod( login_credentials.merge(params) ) 
        response.deletePaymentMethodResult.to_i == payment_method_id.to_i ? true : false     
      rescue
        false
      end      
    end
    
    def debit_bank_account(bank_account, amount)
      params = bank_account.debit_setup(amount)
      response = @socket_driver.ExecuteSocketQuery( login_credentials.merge(params) ) 
      transaction_response = PaymentsGateway::TransactionResponse.new( response['ExecuteSocketQueryResult'] )
    end
    
    def credit_bank_account(bank_account, amount)
      params = bank_account.credit_setup(amount)
      response = @socket_driver.ExecuteSocketQuery( login_credentials.merge(params) ) 
      transaction_response = PaymentsGateway::TransactionResponse.new( response['ExecuteSocketQueryResult'] )
    end
      
    
    
    ###################################
    # Credit Card
    ###################################
    # def get_credit_cards(client_id)
    #   params = {'ClientID' => client_id, 'PaymentMethodID' => 0}    
    #   response = @client_driver.getPaymentMethod( login_credentials.merge(params) ) 
    # 
    #   PaymentsGateway::Client.new( response.getPaymentMethodResult['PaymentMethod'] )
    # end    
    
    def get_credit_card(client_id, account_id)
      raise 'get_credit_card method not implemented yet'
    end
    
    def create_credit_card
      raise 'create_credit_card method not implemented yet'
    end
    
    def update_credit_card
      raise 'update_credit_card method not implemented yet'
    end
    
    def delete_credit_card
      raise 'delete_credit_card method not implemented yet'
    end
    
    private
    
    
    def login_credentials
      {:ticket => Authentication.new(@api_login_id, @api_password).login_hash}
    end
  end
  
end
