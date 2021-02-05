# frozen_string_literal: true

require 'securerandom'

module Paynow
  # Builds uniq key using UUID to be used in the request header
  class IdempotencyKeyBuilder
    def self.build
      new.build
    end

    def build
      SecureRandom.uuid
    end
  end
end
