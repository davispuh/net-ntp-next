# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'net/ntp/next/version'


Gem::Specification.new do |gem|
    gem.name          = 'net-ntp-next'
    gem.version       = Net::NTP::Next::VERSION
    gem.authors       = ['Dāvis']
    gem.email         = ['davispuh@gmail.com']
    gem.description   = 'NTP client library with improved functionality.'
    gem.summary       = 'Improved NTP client library.'
    gem.homepage      = 'https://github.com/davispuh/net-ntp-next'
    gem.license       = 'UNLICENSE'

    gem.files         = `git ls-files`.split($/)
    gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
    gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
    gem.require_paths = ['lib']
    gem.add_dependency 'net-ntp', '>= 2.1.1'
    gem.add_development_dependency 'rspec'
    gem.add_development_dependency 'simplecov'
    gem.add_development_dependency 'yard'
    gem.add_development_dependency 'redcarpet'
end
