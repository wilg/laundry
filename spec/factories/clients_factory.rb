# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :client, class: Laundry::PaymentsGateway::Client do
  	client_id '1'
	  initialize_with do
	  	Laundry::PaymentsGateway::Client.from_response({get_client_response: {get_client_result: {client_record: attributes}}}, FactoryGirl.build(:merchant))
	  end
  end
end