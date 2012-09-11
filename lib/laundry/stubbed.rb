require "rspec/mocks/standalone"

class Module
	def subclasses
		classes = []
		ObjectSpace.each_object(Module) do |m|
			classes << m if m.ancestors.include? self
		end
		classes
	end
end

def stub_all
  # Just stub away all the SOAP requests and such.
  classes = [Laundry::PaymentsGateway::MerchantAuthenticatableDriver, Laundry::PaymentsGateway::Merchant]
  classes.map{|c| [c.subclasses, c] }.flatten.uniq.each do |klass|
    klass.stub(:client_request).and_return true
    klass.stub(:client).and_return true
    klass.any_instance.stub(:setup_client!).and_return true
  end

  # Stub client driver
  Laundry::PaymentsGateway::ClientDriver.any_instance.stub(:find).and_return(Laundry.mock(:client))
  Laundry::PaymentsGateway::ClientDriver.any_instance.stub(:create!).and_return(Laundry.mock(:client).id)

  # Stub account driver
  Laundry::PaymentsGateway::AccountDriver.any_instance.stub(:find).and_return(Laundry.mock(:account))
  Laundry::PaymentsGateway::AccountDriver.any_instance.stub(:create!).and_return(Laundry.mock(:account).id)

  # Stub performing transactions.
  Laundry::PaymentsGateway::Account.any_instance.stub(:perform_transaction).and_return(Laundry.mock(:transaction_response))

  Laundry.stub(:stubbed?).and_return true
end

# Run this code once on the first require to ensure all methods are stubbed
stub_all
