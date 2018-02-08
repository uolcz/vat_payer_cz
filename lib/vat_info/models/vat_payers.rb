module VatInfo
  module Models
    class VatPayers
      attr_accessor :data

      def initialize(params = {})
        @data          = {}
        @data[:platci] = create_vat_payers(params)
      end

      def create_vat_payers(payers)
        payers.map { |payer| VatInfo::Models::VatPayer.new(payer).data }
      end
    end
  end
end
