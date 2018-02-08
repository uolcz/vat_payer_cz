module VatInfo
  class Response
    attr_accessor :status_code, :body, :raw

    def initialize(status_code:, body: {}, raw: {})
      @status_code = status_code
      @body        = body
      @raw         = raw
    end

    def ok?
      status_code == 200
    end
  end
end
