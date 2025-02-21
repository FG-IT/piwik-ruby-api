# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'piwik/version'

Gem::Specification.new do |s|
  s.name          = "autometal-piwik"
  s.version       = Piwik::VERSION
  s.authors       = ["Achilles Charmpilas"]
  s.email         = ["ac@humbuckercode.co.uk"]
  s.description   = %q{A complete Ruby client for the Piwik API}
  s.summary       = %q{A complete Ruby client for the Piwik API}
  s.homepage      = "http://humbuckercode.co.uk/licks/gems/piwik/"
  s.license       = 'MIT'
  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency('xml-simple', '>= 1.1.9')
  s.add_dependency('excon')
  s.add_dependency('activesupport', '>= 3.0', '< 8.0')
  s.add_development_dependency('rspec', '< 3.0')
  s.add_development_dependency('rspec-its', '< 3.0')
end
