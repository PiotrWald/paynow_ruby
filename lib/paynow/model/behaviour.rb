# frozen_string_literal: true

module Paynow
  module Model
    # Adds functionality needed to represent Paynow payments
    module Behaviour
      def self.included(base)
        base.enum status: %i[created pending confirmed rejected error]
      end
    end
  end
end
