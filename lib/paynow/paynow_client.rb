# frozen_string_literal: true

module Paynow
  # Net::HTTP wraper for consuming the Paynow API
  class PaynowClient
    extend Forwardable

    def_delegators Paynow::Configuration, :host, :api_key, :api_version

    def create_payment(body)
      json_body = serialize_payload(body)

      Net::HTTP.post(create_payment_uri, json_body, headers)
    end

    private

    def serialize_payload(body)
      body.transform_keys(&camelize).to_json
    end

    def create_payment_uri
      URI("http://#{host}/payments")
    end

    def headers
      {
        'Api-Key': api_key,
        'Signature': 'signature',
        'Idempotency-Key': 'uniq',
        'Api-Version': api_version,
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      }
    end

    def camelize
      lambda do |key|
        key.to_s.split('_').reduce do |accumulator, value|
          if accumulator
            accumulator + value[0].upcase + value[1..(value.length - 1)]
          else
            value
          end
        end
      end
    end
  end
end
