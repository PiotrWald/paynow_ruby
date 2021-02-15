# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name                  = 'paynow_ruby'
  spec.version               = '0.0.1'
  spec.date                  = '2021-02-15'
  spec.summary               = ''
  spec.authors               = ['Piotr Wald']
  spec.email                 = ['valdpiotr@gmail.com']
  spec.require_paths         = ['lib']
  spec.license               = 'MIT'
  spec.files                 = Dir['LICENSE', 'README.md', 'lib/**/*']
  spec.homepage              = 'https://github.com/PiotrWald/paynow_ruby'
  spec.test_files            = spec.files.grep(/spec/)
  spec.required_ruby_version = '> 2.4'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec', '~> 3.10.0'
end
