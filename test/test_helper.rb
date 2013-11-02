require 'simplecov'
SimpleCov.start

ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/spec'
require "minitest/rails/capybara"

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  DatabaseCleaner.strategy = :transaction
  DatabaseCleaner.clean_with(:truncation)

  def setup
    DatabaseCleaner.start
  end
  
  def teardown
    DatabaseCleaner.clean
  end
end
