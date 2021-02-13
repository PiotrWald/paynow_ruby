# frozen_string_literal: true

module Paynow
  # Centralized configuration for the paynow_ruby gem
  class Configuration
    @host = 'api.paynow.pl'
    @api_key = 'PAYNOW_API_KEY'
    @api_version = 'latest'

    def self.configure
      yield self
    end

    class << self
      attr_accessor :host, :api_key, :api_version, :signature_key
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
