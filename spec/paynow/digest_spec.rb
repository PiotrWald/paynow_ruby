# frozen_string_literal: true

RSpec.describe Paynow::Digest do
  before do
    allow(Paynow::Configuration)
      .to receive(:api_key)
      .and_return('s3ecret-k3y')
  end

  context 'with a string data to hash' do
    let(:data_to_hash) { 'sample_request_content' }

    it 'calculates the signature' do
      signature = described_class.hmac(data_to_hash)
      expect(signature).to eql('LSajZ+A7nXbkhDvp+2YtBV/dVz8xnBZt7W/I0jew7i4=')
    end
  end

  context 'with a nil data to hash' do
    let(:data_to_hash) { nil }

    it 'return nil' do
      signature = described_class.hmac(data_to_hash)
      expect(signature).to be_nil
    end
  end

  context 'with an emptry string data to hash' do
    let(:data_to_hash) { '' }

    it 'calcaultes the signature' do
      signature = described_class.hmac(data_to_hash)
      expect(signature).to eql('Yz7P6XKfaCfSp9JtXvIIinf5G2m6fIt3FWlXHMGbuP8=')
    end
  end
end
