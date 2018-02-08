require 'savon'

module VatInfo
  class SchemaError < StandardError; end

  class Query
    DOCS = 'https://adisspr.mfcr.cz/adistc/adis/idpr_pub/dpr_info/ws_spdph.faces'
    WSDL = 'http://adisrws.mfcr.cz/adistc/axis2/services/rozhraniCRPDPH.rozhraniCRPDPHSOAP?wsdl'.freeze
    TIMEOUT = 2

    def self.call(request, endpoint, wsdl = WSDL, timeout = TIMEOUT)
      client = Savon.client(wsdl: wsdl, open_timeout: timeout)

      begin
        response = client.call(endpoint, xml: request)
        if response.success?
          VatInfo::Response.new(status_code: 200, raw: response.body)
        else
          VatInfo::Response.new(status_code: 503)
        end
      rescue Net::OpenTimeout
        VatInfo::Response.new(status_code: 408)
      rescue Savon::SOAPFault => e
        raise SchemaError, 'The SOAP schema of VAT service may have changed. Go to '\
                           "#{DOCS} to verify. Original error: #{e}"
      end
    end
  end
end
