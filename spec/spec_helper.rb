ENV["RAILS_ENV"] ||= 'test'
require 'simplecov'
SimpleCov.start
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/given'
require 'shoulda/matchers'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.before(:each) do
    Pick.delete_all
    Team.delete_all
    Player.delete_all
  end
end
