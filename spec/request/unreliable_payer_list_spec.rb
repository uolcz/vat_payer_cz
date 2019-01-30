require 'spec_helper'

RSpec.describe VatInfo::Request::UnreliablePayerList do
  it_behaves_like 'a Request'

  describe '.body' do
    it 'adds SeznamNespolehlivyPlatceRequest element' do
      request = VatInfo::Request::UnreliablePayerList.new.body
      expect(request).to have_xml('//xmlns:SeznamNespolehlivyPlatceRequest')
    end
  end
end
