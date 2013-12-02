# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'string_awesome/version'

Gem::Specification.new do |spec|
  spec.name          = 'string_awesome'
  spec.version       = StringAwesome::VERSION
  spec.authors       = ['Tiago Guedes']
  spec.email         = ['tiagopog@gmail.com']
  spec.description   = %q{Awesome and easy-to-use extensions to Ruby String class.}
  spec.summary       = %q{Extensions for Ruby String class}
  spec.homepage      = 'https://github.com/tiagopog/string_awesome'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', ['>= 3.0', '< 5.0']

  spec.add_development_dependency 'bundler"', '~> 1.3'
  spec.add_development_dependency 'rake'
end
