# frozen_string_literal: true

module Paynow
  # Responsible for building a payment from request and response
  class Gateway
    attr_reader :params

    def self.create_payment(*args)
      new(*args).create_payment
    end

    def initialize(params)
      @params = params.transform_keys(&:to_sym)
    end

    def create_payment
      logger.info("[PAYNOW] CREATE PAYMENT external_id=#{params[:external_id]}")

      response = api_client.create_payment(params)

      parsed_response_body = JSON.parse(response.body)

      payment.new(
        request_attributes.merge(
          response: response,
          payment_id: parsed_response_body['paymentId'],
          status: parsed_response_body['status'],
          redirect_url: parsed_response_body['redirectUrl']
        )
      )
    end

    private

    def request_attributes
      params.slice(:amount, :external_id, :description, :buyer)
    end

    def api_client
      Paynow::Configuration.api_client
    end

    def payment
      Paynow::Configuration.payment
    end

    def logger
      Paynow::Configuration.logger
    end
  end
end
