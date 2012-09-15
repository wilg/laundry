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
    stub_all unless require "laundry/stubbed"
  end

  def self.stubbed?
  	false
  end

  def self.mock(type, merge = {})
		o = YAML::load_file(File.expand_path(File.join(__FILE__, "..", "..", "spec", "fixtures", "#{type.to_s}.yml")))
		o.merchant = self.mock(:merchant) if o.respond_to?(:merchant=)
		if merge && !merge.empty?
			o.record = o.record.merge(merge)
		end
		o
	end

end

# Lib
require "laundry/lib/soap_model"

# Payments Gateway
require "laundry/payments_gateway/payments_gateway"
