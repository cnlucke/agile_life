require File.expand_path('../../config/environment', __FILE__)
ENV["SINATRA_ENV"] = "test"

require_relative '../config/environment'
require 'rack/test'
require 'database_cleaner'
require 'rspec/rails'
require 'rspec/autorun'
require 'spec_helper.rb'
# require 'rails_helper.rb'


if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate SINATRA_ENV=test` to resolve the issue.'
end

RSpec.configure do |config|

  config.include Rack::Test::Methods
  DatabaseCleaner.strategy = :truncation

  config.before do
    DatabaseCleaner.clean
  end

  config.after do
    DatabaseCleaner.clean
  end

  config.order = 'default'
end

def __
  raise "Replace __ with test code."
end
