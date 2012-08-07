require "ach-direct/version"
require 'savon'

module ACH
  module Direct
    
    @@sandboxed = true

    def self.sandboxed?
      @@sandboxed
    end
    
    def self.sandboxed=(yn)
      @@sandboxed = yn
    end

  end
end

# Lib
require "ach-direct/lib/soap_model"

# Models
require "ach-direct/models/merchant_authenticatable_model"
require "ach-direct/models/account"
require "ach-direct/models/client"
require "ach-direct/models/merchant"
