# frozen_string_literal: true

RSpec.describe Paynow::Configuration do
  describe 'defaults' do
    it 'returns default host value' do
      expect(described_class.host).to eql('api.paynow.pl')
    end

    it 'returns default api_key value' do
      expect(described_class.api_key).to eql('PAYNOW_API_KEY')
    end

    it 'returns default api_version value' do
      expect(described_class.api_version).to eql('latest')
    end
  end

  describe 'configure' do
    context 'when values get updated' do
      before do
        described_class.configure do |config|
          config.host = 'updated_host'
          config.api_key = 'updated_api_key'
          config.api_version = 'updated_api_version'
          config.signature_key = 'updated_signature_key'
        end
      end

      it 'returns updated host value' do
        expect(described_class.host).to eql('updated_host')
      end

      it 'returns updated api_key value' do
        expect(described_class.api_key).to eql('updated_api_key')
      end

      it 'returns updated api_version value' do
        expect(described_class.api_version).to eql('updated_api_version')
      end

      it 'returns updated signature_key' do
        expect(described_class.signature_key).to eql('updated_signature_key')
      end
    end
  end
end
