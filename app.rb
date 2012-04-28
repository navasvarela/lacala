require 'sinatra'
require 'haml'

class MyApp < Sinatra::Application
	enable :sessions

	configure :production do
		set :haml, { :ugly=>true }
		set :clean_trace, true
		set :css_files, :blob
		set :js_files,  :blob
		
	end

	configure :development do
		set :css_files, :blob
    set :js_files,  :blob
	end

	helpers do
		include Rack::Utils
		alias_method :h, :escape_html
	end
end
require_relative 'routes/init'
require_relative 'models/init'
require_relative 'helpers/init'