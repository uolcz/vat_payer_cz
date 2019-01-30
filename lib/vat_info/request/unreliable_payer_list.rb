module VatInfo
  class Request
    class UnreliablePayerList < VatInfo::Request
      def body
        Nokogiri::XML::Builder.new('encoding' => 'UTF-8') do |xml|
          xml.SeznamNespolehlivyPlatceRequest(xmlns: 'http://adis.mfcr.cz/rozhraniCRPDPH/')
        end.doc
      end
    end
  end
end
