# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account, class: Laundry::PaymentsGateway::Account do
	merchant { build(:merchant) }
	record({
		:merchant_id => "1",
		:client_id => "1",
		:payment_method_id => "1",
		:acct_holder_name => "John Quincy Adams",
		:cc_card_number => nil,
		:cc_expiration_date => nil,
		:cc_card_type => nil,
		:cc_procurement_card => false,
		:ec_account_number => "XXXXXX1234",
		:ec_account_trn => "1234565678",
		:ec_account_type => "CHECKING",
		:note => nil,
		:is_default => false
	})
  end
end