# frozen_string_literal: true

require 'securerandom'

module Paynow
  class IdempotencyKeyBuilder
    def self.build
      new.build
    end

    def build
      SecureRandom.uuid
    end
  end
end
