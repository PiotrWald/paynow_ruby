# frozen_string_literal: true

RSpec.describe Paynow::Payment do
  describe '.create' do
    let(:create_payment_response) { json_fixture(:create_payment_response) }
    let(:parsed_response) { JSON.parse(create_payment_response) }
    let(:payment_id) { parsed_response['paymentId'] }
    let(:redirect_url) { parsed_response['redirectUrl'] }
    let(:status) { parsed_response['status'] }
    let(:amount) { 10 }
    let(:external_id) { 'external_id' }
    let(:description) { 'description' }
    let(:buyer) { { email: 'test@example.com' } }
    let(:payment_params) do
      {
        amount: amount,
        external_id: external_id,
        description: description,
        buyer: buyer,
      }
    end

    let(:paynow_host) { 'api.paynow.pl' }

    before do
      stub_request(:post, "https://#{paynow_host}/v1/payments")
        .with(body: /10.*test@example.com/)
        .to_return(status: 201, body: create_payment_response)
    end

    it 'returns the Paynow::Payment' do
      payment = described_class.create(payment_params)

      expect(payment).to be_a(described_class)
    end

    it 'makes a HTTP call to Paynow API' do
      described_class.create(payment_params)

      expect(a_request(:post, "https://#{paynow_host}/v1/payments")).to have_been_made.once
    end

    it 'returns a payment with populated response' do
      payment = described_class.create(payment_params)

      expect(payment.response).to be_a(Net::HTTPCreated)
    end

    it 'returns a payment with populated amount' do
      payment = described_class.create(payment_params)

      expect(payment.amount).to eql(amount)
    end

    it 'returns a payment with populated external ID' do
      payment = described_class.create(payment_params)

      expect(payment.external_id).to eql(external_id)
    end

    it 'returns a payment with populated description' do
      payment = described_class.create(payment_params)

      expect(payment.description).to eql(description)
    end

    it 'returns a payment with populated buyer' do
      payment = described_class.create(payment_params)

      expect(payment.buyer).to eql(buyer)
    end

    it 'returns a payment with populated payment ID' do
      payment = described_class.create(payment_params)

      expect(payment.payment_id).to eql(payment_id)
    end

    it 'returns a payment with populated status' do
      payment = described_class.create(payment_params)

      expect(payment.status).to eql(status)
    end

    it 'returns a payment with populated status' do
      payment = described_class.create(payment_params)

      expect(payment.redirect_url).to eql(redirect_url)
    end
  end
end
