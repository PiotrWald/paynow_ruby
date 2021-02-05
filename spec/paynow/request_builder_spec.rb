# frozen_string_literal: true

RSpec.describe Paynow::RequestBuilder do
  let(:amount) { 45_671 }
  let(:description) { 'Some description' }
  let(:external_id) { '234567898654' }
  let(:email) { 'aaa@bbb.pl' }
  let(:first_name) { 'John' }

  let(:params) do
    {
      "external_id": external_id,
    }
  end

  it 'trfnsforms keys to cammel case' do
    expect(described_class.build(params)).to eql("{\"externalId\":\"#{external_id}\"}")
  end
end
