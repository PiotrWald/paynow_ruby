# frozen_string_literal: true

module Paynow
  # Calculates a digest of request body for the integrity verification
  class SignatureCalculator
    attr_reader :data

    def self.call(data)
      new(data).call
    end

    def initialize(data)
      @data = data
    end

    def call
      return unless data

      mac = OpenSSL::HMAC.digest('SHA256', key, String(data))

      Base64.encode64(mac).strip
    end

    private

    def key
      Paynow::Configuration.api_key
    end
  end
end
