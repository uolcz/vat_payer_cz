# VAT payer info CZ
This is Ruby wrapper for [web service for "searching information about reliability of VAT payers and their bank accounts" of Czech Republic Ministry of finance.](http://www.etrzby.cz/cs/index)

## Installation
`gem install 'vat_payer_cz'`

## Usage
The web service has the following three end-points:
- standard VAT payer info
- extended VAT payer info
- list of unreliable VAT payers

This gem currently implements 'standard VAT payer info'.

# Standard VAT payer info
```ruby
vat_ids = %w(CZ27169278 CZ26168685)
VatInfo.unreliable_payer(*vat_ids)
```
You should see something like this:
```shell
=> #<VatInfo::Response:0x0000000001ff61e8
 @body=
  {:status=>{:status_code=>"0", :status_text=>"OK", :odpoved_generovana=>"2018-02-08"},
   :platci=>
    [{:nespolehlivy_platce=>"NE",
      :datum_zverejneni=>nil,
      :dic=>"CZ27169278",
      :cislo_fu=>"451",
      :ucty=>
       [{:predcisli=>nil, :cislo=>"1041150202", :kod_banky=>"5500", :iban=>nil, :datum_zverejneni=>"2013-04-01"},
        {:predcisli=>nil, :cislo=>"6021446666", :kod_banky=>"6000", :iban=>nil, :datum_zverejneni=>"2013-12-05"},
        {:predcisli=>nil, :cislo=>"2400915487", :kod_banky=>"2010", :iban=>nil, :datum_zverejneni=>"2016-05-05"}]},
...
```
## Response
Object `VatInfo::Response`
### status_code
`VatInfo::Response.status_code => String`
200 - OK: Valid response was received.
408 - Request Timeout: the web service timed out.
503 - Service Unavailable: there was another error fetching the response.

### body
Empty attributes have `nil` value.

`VatInfo::Response.body => Hash`
```ruby
{
  status: { Status }
  platci: [ { Payer }, .. ]
}
```
#### Status
See official docs for explanation.
```ruby
{
  status_code: String,
  status_text: String,
  odpoved_generovana: String # ISO 8601 Date
}
```
#### Payer
```ruby
{
  nespolehlivy_platce: String, # "ANO" | "NE" | "NENALEZEN"
  datum_zverejneni: String, # ISO 8601 Date
  dic: String,
  cislo_fu: String,
  ucty: [ { Account }, .. ]
}
```
#### Account
```ruby
{
  predcisli: String, # only Czech accounts
  cislo: String, # only Czech accounts
  kod_banky: String, # only Czech accounts
  iban: String # Czech and foreign accounts
}
```

## Schema changes
The client will raise `VatInfo::SchemaError` exception if it thinks the schema have changed.

## Official web service docs
In Czech: https://adisspr.mfcr.cz/adistc/adis/idpr_pub/dpr_info/ws_spdph.faces
