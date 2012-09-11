# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	factory :transaction_response, class: Laundry::PaymentsGateway::TransactionResponse do
		merchant { build(:merchant) }
		record({
			:pg_response_type => "A",
			:pg_response_code => "A01",
			:pg_response_description => "APPROVED",
			:pg_authorization_code => "12345678",
			:pg_trace_number => "AAABCCED-C99D-4971-A218-49308439DABCD",
			:pg_merchant_id => "1",
			:pg_transaction_type => "23",
			:pg_total_amount => "25.0",
			:ecom_consumerorderid => "order21",
			:pg_client_id => "1",
			:pg_payment_method_id => "1"
		})
	end
end
