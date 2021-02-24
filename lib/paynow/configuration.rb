# frozen_string_literal: true

require 'logger'

module Paynow
  # Centralized configuration for the paynow_ruby gem
  class Configuration
    @default_logger = Logger.new(STDOUT)

    def self.configure
      yield self
    end

    class << self
      attr_accessor :host, :api_key, :api_version, :signature_key, :user_agent, :logger
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

    def self.logger
      @logger || @default_logger
    end
  end
end
