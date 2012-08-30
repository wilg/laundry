# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :merchant, class: Laundry::PaymentsGateway::Merchant do
		id '123456'
		api_login_id 'abc123'
		api_password 'secretsauce'
		transaction_password 'moneymoneymoney'
	end
end