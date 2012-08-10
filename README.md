#Laundry [![Build Status](https://secure.travis-ci.org/supapuerco/laundry.png)](http://travis-ci.org/supapuerco/laundry) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/supapuerco/laundry)

Have you ever wanted to use [ACH Direct](http://www.achdirect.com)'s [Payments Gateway](http://paymentsgateway.com) SOAP API? Neither did anyone. However, with this little gem you should be able to interact with it without going too terribly nuts.

The basic idea is to have a somewhat ActiveRecord-y syntax to making payments, updating client information, etc.

[View the Rdoc](http://rdoc.info/github/supapuerco/laundry/master/frames)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'laundry'
```

There is a [bug in Savon's XML parser](https://github.com/rubiii/nori/issues/19) that can affect you if you are intending to serialize any of Laundry's objects to YAML. For the time being, adding the following line to your Gemfile can resolve this:

```ruby
gem 'nori', git: 'git@github.com:supapuerco/nori.git' # Fixes some YAML serialization issues.
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install laundry

## Usage

First, set up your merchant **account details**, possibly in a Rails initializer. (You're not limited to this singleton thing, but it's pretty useful if you just have one account.)

```ruby
Laundry::PaymentsGateway::Merchant.default_merchant({
  id: '123456', 
  api_login_id: 'abc123', 
  api_password: 'secretsauce', 
  transaction_password: 'moneymoneymoney'
})
```

In development? You should probably **sandbox** this baby:

```ruby
Laundry.sandboxed = !Rails.env.production?
```

Then you can **find a client**:

```ruby
client = Laundry::PaymentsGateway::Merchant.default_merchant.clients.find(10)
```

Create a **bank account**:

```ruby
client.accounts.create!({
  acct_holder_name: user.name,
  ec_account_number: '12345678912345689', 
  ec_account_trn: '123457890',
  ec_account_type: "CHECKING"
})
```

**Send some money**:
```ruby
account.debit_cents 1250
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
