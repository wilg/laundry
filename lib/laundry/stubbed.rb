require "rspec/mocks/standalone"
require 'factory_girl'
FactoryGirl.find_definitions
include FactoryGirl::Syntax::Methods

class Module
	def subclasses
		classes = []
		ObjectSpace.each_object(Module) do |m|
			classes << m if m.ancestors.include? self
		end
		classes
	end
end

# Just stub away all the SOAP requests and such.
classes = [Laundry::PaymentsGateway::MerchantAuthenticatableDriver, Laundry::PaymentsGateway::Merchant]
classes.map{|c| [c.subclasses, c] }.flatten.uniq.each do |klass|
	klass.stub(:client_request).and_return true
	klass.stub(:client).and_return true
	klass.any_instance.stub(:setup_client!).and_return true
end

# Stub client driver
Laundry::PaymentsGateway::ClientDriver.any_instance.stub(:find).and_return(build(:client))