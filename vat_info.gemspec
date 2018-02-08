lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vat_info/version'

Gem::Specification.new do |spec|
  spec.name          = 'vat_payer_cz'
  spec.version       = VatInfo::VERSION
  spec.authors       = ['Tomas Landovsky']
  spec.email         = ['landovsky@gmail.com']

  spec.summary       = 'Ruby wrapper for web service providing info about Czech VAT payers.'
  spec.description   = 'Using mfcr.cz SOAP API to get information about Czech VAT payers.'
  spec.homepage      = 'https://github.com/ucetnictvi-on-line/vat_payer_cz'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'savon'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
