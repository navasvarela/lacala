ENV['RACK_ENV'] = "test"
require 'simplecov'
SimpleCov.start
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

require 'webrat'
require 'rack/test'

Webrat.configure do |conf|
  conf.mode = :rack
end

module MyHelpers
  def app
    Sinatra::Application
  end
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include Webrat::Methods
  conf.include Webrat::Matchers
  conf.include MyHelpers
  conf.around(:each) do |example|
    DB.transaction(:rollback=>:always){example.run}
  end
end
