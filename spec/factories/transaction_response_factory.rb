# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :transaction_response, class: Laundry::PaymentsGateway::TransactionResponse do
		pg_response_type "A"
		initialize_with { Laundry::PaymentsGateway::TransactionResponse.from_response(attributes, FactoryGirl.build(:merchant)) }
	end
end