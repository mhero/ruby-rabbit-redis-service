# frozen_string_literal: true

eval_gemfile File.join(File.dirname(__FILE__), 'Gemfile.tip') if File.exist?('Gemfile.tip')

source 'https://rubygems.org' do
  gem 'activesupport'
  gem 'bunny', '>= 2.19.0'
  gem 'deep_merge'
  gem 'dotenv'
  gem 'faraday'
  gem 'faraday_middleware'
  gem 'fast_jsonapi'
  gem 'logger'
  gem 'puma', '>= 6.0.2'
  gem 'redis'
  gem 'require_all'
  gem 'sinatra', '>= 3.0.4'
  gem 'xmlhasher'

  group :test, :development do
    gem 'debug'
    gem 'mock_redis'
    gem 'rack-test'
    gem 'rerun'
    gem 'rspec'
    gem 'rubocop'
    gem 'simplecov', require: false
    gem 'vcr'
    gem 'webmock'
  end
end
