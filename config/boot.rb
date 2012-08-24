ENV["RACK_ENV"] ||= "development"

require 'bundler'
Bundler.setup

Bundler.require(:default, ENV["RACK_ENV"].to_sym)

Dir["./models/**/*.rb"].each { |f| require f }
Dir["./helpers/**/*.rb"].each { |f| require f }
