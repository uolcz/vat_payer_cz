module VatInfo
  module Models
    class Status
      attr_accessor :data, :params

      def initialize(params = {})
        @params        = params
        @data          = {}
        @data[:status] = create_status
      end

      def create_status
        {
          status_code:        params.fetch(:@status_code),
          status_text:        params.fetch(:@status_text),
          odpoved_generovana: params.fetch(:@odpoved_generovana)
        }
      rescue KeyError => e
        raise InvalidStructure, "Response XML is missing required attributes.\n" \
                                          "Input params were: #{params}\n" \
                                          "Rescued error: #{e}"
      end
    end
  end
end
