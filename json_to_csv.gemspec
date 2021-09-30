# encoding: utf-8
# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'json_to_csv/version'

Gem::Specification.new do |s|
    s.name        = 'json_to_csv'
    s.version     = '0.0.1'
    s.summary     = "Convert a JSON file into a CSV"
    s.description = "A Ruby Gem to convert JSON files to CSV"
    s.authors     = ["Christophe VALENTIN"]
    s.email       = 'christopheasaservice@gmail.com'
    s.homepage    = 'https://rubygems.org/gems/json_to_csv'
    s.license       = 'MIT'

    s.require_paths = ['lib']
    s.files = `git ls-files`.split($RS).reject do |file|
        file =~ %r{^(?:
       spec/.*
       |Gemfile
       |\.rspec
       |\.gitignore
       )$}x
      end
      s.version = JsonToCsv::Version::STRING
      s.platform = Gem::Platform::RUBY
      s.required_ruby_version = '>= 2.3.0'
      s.add_development_dependency('rspec', '~> 3.6')
      s.add_development_dependency('rspec-its', '~> 1.2.0')
  end