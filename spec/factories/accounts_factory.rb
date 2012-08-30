# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account, class: Laundry::PaymentsGateway::Client do
  	payment_method_id '1'
	  initialize_with do
	  	Laundry::PaymentsGateway::Account.from_response({get_payment_method_response: {get_payment_method_result: {payment_method: attributes}}}, FactoryGirl.build(:merchant))
	  end
  end
end