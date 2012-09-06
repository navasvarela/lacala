#!/home2/salatecs/.rvm/rubies/ruby-1.9.3-p194/bin/ruby

require 'rubygems'

fastcgi_log = File.open("fastcgi.log", "a")
STDOUT.reopen fastcgi_log
STDERR.reopen fastcgi_log
STDOUT.sync = true

print %x[which ruby]
# You must put the gems on the path
ENV["GEM_HOME"] = "/home2/salatecs/.rvm/gems/ruby-1.9.3-p194@global"
# sinatra should load now
require 'sinatra'

module Rack
  class Request
    def path_info
      @env["REDIRECT_URL"].to_s
    end
    def path_info=(s)
      @env["REDIRECT_URL"] = s.to_s
    end
  end
end

require_relative 'app'

builder = Rack::Builder.new do
  use Rack::ShowStatus
  use Rack::ShowExceptions
  
  run Sinatra::Application
end

Rack::Handler::FastCGI.run(builder)
