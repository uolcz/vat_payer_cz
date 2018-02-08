module VatInfo
  module Models
    class VatPayer
      attr_accessor :data

      def initialize(params)
        @data                       = {}
        @data[:nespolehlivy_platce] = params.fetch(:@nespolehlivy_platce)
        @data[:datum_zverejneni]    = params.fetch(:@datum_zverejneni_nespolehlivosti, nil)
        @data[:dic]                 = params.fetch(:@dic)
        @data[:cislo_fu]            = params.fetch(:@cislo_fu, nil)
        accounts                    = params.fetch(:zverejnene_ucty, nil)
        @data[:ucty]                = accounts ? create_accounts(accounts[:ucet]) : {}
      rescue KeyError => e
        raise InvalidStructure, "Response XML is missing required attributes.\n" \
                                "Input params were: #{params}\n" \
                                "Rescued error: #{e}"
      end

      def create_accounts(accounts)
        VatInfo::Utils.wrap_in_array(accounts).map do |account|
            standard     = account.fetch(:standardni_ucet, nil)
            non_standard = account.fetch(:nestandardni_ucet, nil)

            params = standard ? standard_account(standard) : non_standard_account(non_standard)
            params.merge(datum_zverejneni: account[:@datum_zverejneni])
        end
      end

      def standard_account(data)
        {
          predcisli: data.fetch(:@predcisli, nil),
          cislo: data.fetch(:@cislo, nil),
          kod_banky: data.fetch(:@kod_banky, nil),
          iban: nil
        }
      end

      def non_standard_account(data)
        {
          predcisli: nil,
          cislo: nil,
          kod_banky: nil,
          iban: data.fetch(:@cislo, nil)
        }
      end
    end
  end
end
