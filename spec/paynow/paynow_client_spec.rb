# frozen_string_literal: true

RSpec.describe Paynow::PaynowClient do
  let(:paynow_host) { 'api.paynow.pl' }
  let(:api_key) { 'PAYNOW_API_KEY' }
  let(:api_version) { 'latest' }
  let(:amount) { 45_671 }
  let(:description) { 'Some description' }
  let(:external_id) { '234567898654' }
  let(:email) { 'aaa@bbb.pl' }
  let(:idempotency_key) { 'f74e146-d766-45c6-88a7-da73aa02d199' }
  let(:service_unavailable_response) { json_fixture(:service_unavailable_response) }

  let(:headers) do
    {
      'Api-Key': api_key,
      'Signature': '89VBGhLXAXKxC9ke8d1eqsrpulTjs90YDZyFq+rw3KU=',
      'Idempotency-Key': idempotency_key,
      'Api-Version': api_version,
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'User-Agent': 'Ruby',
      'Host': paynow_host,
      'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    }
  end

  before do
    allow(SecureRandom).to receive(:uuid).and_return(idempotency_key)

    allow(Paynow::Configuration)
      .to receive(:signature_key)
      .and_return('s3ecret-k3y')
  end

  describe '#create_payment' do
    before { stub_request(:post, 'https://api.paynow.pl/v1/payments') }

    it 'makes an HTTP request to Paynow API' do
      described_class.create_payment(
        "amount": amount,
        "description": description,
        "external_id": external_id,
        "buyer": {
          "email": email,
          "phone": {},
        }
      )

      body = {
        "amount": amount,
        "description": description,
        "externalId": external_id,
        "buyer": {
          "email": email,
          "phone": {},
        },
      }

      expect(WebMock)
        .to have_requested(:post, "https://#{paynow_host}/v1/payments")
        .with(body: body.to_json, headers: headers)
    end

    describe 'error handling' do
      before do
        stub_request(:post, 'https://api.paynow.pl/v1/payments')
          .to_return(status: 503, body: service_unavailable_response)
      end

      it 'handles Paynow service unavailable' do
        expect(
          described_class.create_payment(
            "amount": amount,
            "description": description,
            "external_id": external_id,
            "buyer": {
              "email": email,
              "phone": {},
            }
          )
        ).to be_a(Net::HTTPServiceUnavailable)
      end
    end
  end
end
