require "laundry/version"
require 'savon'

module Laundry
  
  @@sandboxed = true

  def self.sandboxed?
    @@sandboxed
  end
  
  def self.sandboxed=(yn)
    @@sandboxed = yn
  end

end

# Lib
require "laundry/lib/soap_model"

# Payments Gateway
require "laundry/payments_gateway/payments_gateway"