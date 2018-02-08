require 'spec_helper'

RSpec.describe VatInfo::Models::Status do
  describe '.new' do
    it 'creates VatPayer hash in correct structure' do
      params = VCR.use_cassette('vat_payer_data') do
        response = VatInfo.unreliable_payer('CZ26168685')
        response.raw
      end[:status_nespolehlivy_platce_response][:status]

      vat_status = VatInfo::Models::Status.new(params).data
      expect(vat_status[:status][:status_code]).to eq '0'
      expect(vat_status[:status][:status_text]).to eq 'OK'
    end

    it 'raises InvalidStructure exception if input does not contain mandatory data' do
      expect { VatInfo::Models::Status.new(a: 1) }.to raise_error(VatInfo::Models::InvalidStructure)
    end
  end
end
