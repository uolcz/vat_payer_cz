shared_examples 'a Request' do
  let(:request) { described_class.new }

  describe '.envelope' do
    it 'creates the envelope element' do
      expect(request.envelope).to have_xml('//soapenv:Envelope')
    end

    it 'creates the body element' do
      expect(request.envelope).to have_xml('//soapenv:Body')
    end
  end

  describe '.to_xml' do
    it 'combines shared envelope and specific body to XML' do
      body = request.body.root
      expect(request.to_xml).to include body
    end
  end
end
