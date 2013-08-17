# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vcf'

Gem::Specification.new do |spec|
  spec.name          = 'vcf'
  spec.version       = VCF::VERSION
  spec.authors       = ['DeLynn Berry']
  spec.email         = ['delynn@gmail.com']
  spec.description   = %q{}
  spec.summary       = %q{}
  spec.homepage      = 'https://github.com/delynn/vcf'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'vcardigan', '~> 0.0.2'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
end
