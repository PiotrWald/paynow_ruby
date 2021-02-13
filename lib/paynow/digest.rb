# frozen_string_literal: true

require 'openssl'

module Paynow
  # Digest of request body for the integrity verification
  class Digest
    attr_reader :data

    def self.hmac(data)
      new(data).hmac
    end

    def initialize(data)
      @data = data
    end

    def hmac
      return unless data

      digest = OpenSSL::HMAC.digest('SHA256', key, data)

      Base64.encode64(digest).strip
    end

    private

    def key
      Paynow::Configuration.signature_key
    end
  end
end
