require "ach-direct/version"

# Models
require "ach-direct/models/account"
require "ach-direct/models/client"
require "ach-direct/models/merhant"

module ACH
  module Direct

    def sandboxed?
      @@sandboxed || true
    end
    
    def sandboxed=(yn)
      @@sandboxed = yn
    end

  end
end
