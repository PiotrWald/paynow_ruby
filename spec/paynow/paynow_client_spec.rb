# frozen_string_literal: true

RSpec.describe Paynow::PaynowClient do
  subject(:paynow_client) { described_class.new }

  let(:paynow_host) { 'api.paynow.pl' }
  let(:api_key) { 'PAYNOW_API_KEY' }
  let(:api_version) { 'latest' }
  let(:amount) { 45_671 }
  let(:description) { 'Some description' }
  let(:external_id) { '234567898654' }
  let(:email) { 'aaa@bbb.pl' }

  let(:headers) do
    {
      'Api-Key': 'PAYNOW_API_KEY',
      'Signature': 'signature',
      'Idempotency-Key': 'uniq',
      'Api-Version': 'latest',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'User-Agent': 'Ruby',
      'Host': 'api.paynow.pl',
      'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3'
    }
  end

  before do
    allow(Paynow::Configuration).to receive(:host).and_return(paynow_host)
    allow(Paynow::Configuration).to receive(:api_key).and_return(api_key)
    allow(Paynow::Configuration).to receive(:api_version).and_return(api_version)
  end

  describe '#create_payment' do
    it 'makes an HTTP request to Paynow API' do
      stub_request(:any, "#{paynow_host}/payments")
      paynow_client.create_payment(
        "amount": amount,
        "description": description,
        "external_id": external_id,
        "buyer": {
          "email": email,
          "phone": {}
        }
      )

      body = {
        "amount": amount,
        "description": description,
        "externalId": external_id,
        "buyer": {
          "email": email,
          "phone": {}
        }
      }

      expect(WebMock)
        .to have_requested(:post, "#{paynow_host}/payments")
        .with(body: body.to_json, headers: headers)
    end
  end
end
