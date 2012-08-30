require "laundry/version"
require 'savon'

# Don't log Laundry xmls to STDOUT.
Savon.configure do |config|
  config.log = false
  config.log_level = :error
  HTTPI.log = false
end

module Laundry

  @@sandboxed = true

  def self.sandboxed?
    @@sandboxed
  end

  def self.sandboxed=(yn)
    @@sandboxed = yn
  end

  def self.stub!
    require "laundry/stubbed"
  end

end

# Lib
require "laundry/lib/soap_model"

# Payments Gateway
require "laundry/payments_gateway/payments_gateway"