# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :client, class: Laundry::PaymentsGateway::Client do
	merchant { build(:merchant) }
	record({
		:merchant_id => "1",
		:client_id => "1",
		:first_name => "Test",
		:last_name => "Person",
		:company_name => nil,
		:address1 => nil,
		:address2 => nil,
		:city => nil,
		:state => nil,
		:postal_code => nil,
		:country_code => nil,
		:phone_number => nil,
		:fax_number => nil,
		:email_address => nil,
		:shipto_first_name => nil,
		:shipto_last_name => nil,
		:shipto_company_name => nil,
		:shipto_address1 => nil,
		:shipto_address2 => nil,
		:shipto_city => nil,
		:shipto_state => nil,
		:shipto_postal_code => nil,
		:shipto_country_code => nil,
		:shipto_phone_number => nil,
		:shipto_fax_number => nil,
		:consumer_id => nil,
		:status => "Active"
		})
  end
end