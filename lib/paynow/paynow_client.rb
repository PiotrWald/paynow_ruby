# frozen_string_literal: true

require 'net/http'

module Paynow
  # Net::HTTP wraper for consuming the Paynow API
  class PaynowClient
    attr_reader :body

    def self.create_payment(body)
      new(body).create_payment
    end

    def initialize(body)
      @body = body
    end

    def create_payment
      uri = URI("https://#{host}/v1/payments")

      Net::HTTP.post(uri, json_body, headers)
    end

    private

    def headers
      {
        'Api-Key': api_key,
        'Signature': signature,
        'Idempotency-Key': idempotency_key,
        'Api-Version': api_version,
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'User-Agent': user_agent,
      }
    end

    def json_body
      Paynow::Configuration.request_builder.build(body)
    end

    def idempotency_key
      Paynow::Configuration.idempotency_key_builder.build
    end

    def host
      Paynow::Configuration.host
    end

    def api_key
      Paynow::Configuration.api_key
    end

    def api_version
      Paynow::Configuration.api_version
    end

    def signature
      Paynow::Configuration.digest.hmac(json_body)
    end

    def user_agent
      Paynow::Configuration.user_agent
    end
  end
end
