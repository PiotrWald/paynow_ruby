# frozen_string_literal: true

module Paynow
  # Value object with information about the payment
  class Payment
    attr_reader :amount,
                :buyer,
                :description,
                :payment_id,
                :status,
                :redirect_url,
                :response,
                :external_id

    def self.create(*args)
      Paynow::Configuration.gateway.create_payment(*args)
    end

    def initialize(attributes)
      @response = attributes[:response]
      @amount = attributes[:amount]
      @description = attributes[:description]
      @buyer = attributes[:buyer]
      @payment_id = attributes[:payment_id]
      @status = attributes[:status]
      @redirect_url = attributes[:redirect_url]
      @external_id = attributes[:external_id]
    end

    def created?
      response.code == '201' && status == 'NEW'
    end
  end
end
