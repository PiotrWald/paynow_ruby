# frozen_string_literal: true

module Paynow
  # Net::HTTP wraper for consuming the Paynow API
  class PaynowClient
    attr_reader :body

    def self.create_payment(body)
      new(body: body).create_payment
    end

    def initialize(body: nil)
      @body = body
    end

    def create_payment
      Net::HTTP.post(
        create_payment_uri,
        json_body,
        headers
      )
    end

    private

    def create_payment_uri
      URI("http://#{host}/payments")
    end

    def json_body
      body.transform_keys(&camelize_proc).to_json
    end

    def headers
      {
        'Api-Key': api_key,
        'Signature': signature,
        'Idempotency-Key': 'uniq',
        'Api-Version': api_version,
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }
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
      Paynow::Configuration.signature_calculator.call(json_body)
    end

    def camelize_proc
      Paynow::Configuration.camelize_proc
    end
  end
end
