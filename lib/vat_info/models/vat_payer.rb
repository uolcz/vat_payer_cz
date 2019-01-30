module VatInfo
  module Models
    class VatPayer
      attr_accessor :data

      def initialize(params)
        @data                       = {}
        @data[:nespolehlivy_platce] = params.fetch(:@nespolehlivy_platce)
        @data[:dic]                 = params.fetch(:@dic)
        @data[:datum_zverejneni]    = params[:@datum_zverejneni_nespolehlivosti]
        @data[:cislo_fu]            = params[:@cislo_fu]
        accounts                    = params[:zverejnene_ucty]
        @data[:ucty]                = accounts ? create_accounts(accounts[:ucet]) : {}
      rescue KeyError => e
        raise InvalidStructure, "Response XML is missing required attributes.\n" \
                                "Input params were: #{params}\n" \
                                "Rescued error: #{e}"
      end

      def create_accounts(accounts)
        VatInfo::Utils.wrap_in_array(accounts).map do |account|
          standard     = account[:standardni_ucet]
          non_standard = account[:nestandardni_ucet]

          params = standard ? standard_account(standard) : non_standard_account(non_standard)
          params.merge(datum_zverejneni: account[:@datum_zverejneni])
        end
      end

      def standard_account(data)
        {
          predcisli: data[:@predcisli],
          cislo: data[:@cislo],
          kod_banky: data[:@kod_banky],
          iban: nil
        }
      end

      def non_standard_account(data)
        {
          predcisli: nil,
          cislo: nil,
          kod_banky: nil,
          iban: data[:@cislo]
        }
      end
    end
  end
end
