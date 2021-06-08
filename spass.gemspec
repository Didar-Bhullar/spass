# frozen_string_literal: true

require_relative 'lib/spass/version'

Gem::Specification.new do |s|
  s.name          = 'spass'
  s.version       = Spass::VERSION
  s.authors       = ['didar-bhullar']
  s.email         = ['didar.s.bhullar@gmail.com']
  s.summary       = 'Library to generate random website passwords'
  s.homepage      = 'https://github.com/Didar-Bhullar/spass'
  s.license       = 'MIT'
  s.files         = Dir['lib/**/*.rb', 'README.md', 'bin/*']
  s.bindir        = 'exe'
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']
  s.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end
