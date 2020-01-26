# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-empty_lines_around_body-check'
  spec.version     = '0.1.1'
  spec.homepage    = 'https://github.com/usev6/puppet-lint-empty_lines_around_body-check'
  spec.license     = 'MIT'
  spec.author      = 'Christian Bartolomäus'
  spec.email       = 'use_v6@aglaz.de'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.test_files  = Dir['spec/**/*']
  spec.summary     = 'A puppet-lint plugin to check for empty lines around '\
                     'the body of blocks.'
  spec.description = <<-END_OF_DESC
    A puppet-lint plugin to check for empty lines around the body of blocks.
  END_OF_DESC

  spec.add_dependency             'puppet-lint', '~> 2.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rspec-json_expectations'
  spec.add_development_dependency 'simplecov'
  ## rake 12.3 requires Ruby >= 2.0.0
  # spec.add_development_dependency 'rake', '< 12.3'
  spec.add_development_dependency 'rake'
end
