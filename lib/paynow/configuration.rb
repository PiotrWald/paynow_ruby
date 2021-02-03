# frozen_string_literal: true

module Paynow
  # Centralized configuration for the paynow_ruby gem
  class Configuration
    def self.host
      'api.paynow.pl'
    end

    def self.api_key
      'PAYNOW_API_KEY'
    end

    def self.api_version
      'latest'
    end

    def self.request_builder
      Paynow::RequestBuilder
    end

    def self.digest
      Paynow::Digest
    end

    def self.api_client
      Paynow::PaynowClient
    end

    def self.idempotency_key_builder
      Paynow::IdempotencyKeyBuilder
    end

    def self.gateway
      Paynow::Gateway
    end

    def self.payment
      Paynow::Payment
    end
  end
end
