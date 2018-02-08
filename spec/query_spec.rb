require 'spec_helper'

describe VatInfo::Query do
  context 'with correct input xml' do
    it 'returns Response object with 200 status code' do
      VCR.use_cassette('query_success') do
        request  = VatInfo::Request::UnreliablePayer.new('CZ0980980').to_xml
        response = VatInfo::Query.call(request, :get_status_nespolehlivy_platce)
        expect(response).to be_a VatInfo::Response
        expect(response.status_code).to eq 200
      end
    end
  end

  context 'with incorrect input xml' do
    it 'raises VatInfo::SchemaError' do
      bad_xml = '<?xml version="1.0" encoding="UTF-8"?>'
      VCR.use_cassette('query_failure') do
        expect do
          VatInfo::Query.call(bad_xml, :get_status_nespolehlivy_platce)
        end.to raise_error(VatInfo::SchemaError)
      end
    end
  end
end
