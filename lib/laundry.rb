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

# Models
require "laundry/models/merchant_authenticatable_model"
require "laundry/models/account"
require "laundry/models/client"
require "laundry/models/merchant"
