module Paynow
  module Model
    module Behaviour
      def self.included(base)
        base.enum status: %i[created pending confirmed rejected error]
      end
    end
  end
end
