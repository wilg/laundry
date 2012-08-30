require 'spec_helper'

describe Laundry::PaymentsGateway::Merchant do

	let(:merchant) { build :merchant }

	describe "#find" do

			it "returns a client" do
				merchant.clients.find(10).class.should == Laundry::PaymentsGateway::Client
			end

	end

end
