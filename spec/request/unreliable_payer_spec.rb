require 'spec_helper'

RSpec.describe VatInfo::Request::UnreliablePayer do
  it_behaves_like 'a Request'

  describe '.body' do
    it 'adds StatusNespolehlivyPlatceRequest element' do
      request = VatInfo::Request::UnreliablePayer.new('CZ7407174456').body
      expect(request).to have_xml('//xmlns:StatusNespolehlivyPlatceRequest')
    end

    it 'adds dic elements' do
      request = VatInfo::Request::UnreliablePayer.new('CZ7407174456', 'CZ7407174451').body
      expect(request.xpath('//xmlns:dic').count).to eq 2
      expect(request.xpath('//xmlns:dic').to_s).to eq '<dic>CZ7407174456</dic><dic>CZ7407174451</dic>'
    end
  end
end
