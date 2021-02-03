module Paynow
  class Gateway
    attr_reader :params

    def self.create_payment(*args)
      new(*args).create_payment
    end

    def initialize(params)
      @params = params
    end

    def create_payment
      response = api_client.create_payment(params)

      parsed_response_body = JSON.parse(response.body)

      payment.new(
        response: response,
        amount: params[:amount],
        external_id: params[:external_id],
        description: params[:description],
        buyer: params[:buyer],
        payment_id: parsed_response_body['paymentId'],
        status: parsed_response_body['status'],
        redirect_url: parsed_response_body['redirectUrl'],
      )
    end

    private

    def api_client
      Paynow::Configuration.api_client
    end

    def payment
      Paynow::Configuration.payment
    end
  end
end
