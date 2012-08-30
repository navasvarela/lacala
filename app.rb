require 'sinatra'
require 'sinatra/assetpack'
require 'haml'
require 'sequel'
require 'json'
require 'sinatra/support'
require 'sinatra/reloader'

class MyApp < Sinatra::Application
  enable :sessions

  configure :production do
    set :haml, { :ugly=>true }
    set :clean_trace, true

  end

  configure :development do
    register Sinatra::Reloader
  end

end

# Assets configuration. Needs to go outside Sinatra::Application to work.
assets {
  serve '/js',     from: 'public/js'        # Optional
  serve '/css',    from: 'public/css'       # Optional
  serve '/images', from: 'public/img'    # Optional
  serve '/bootstrap/css', from: 'public/bootstrap/css'
  serve '/bootstrap/js', from: 'public/bootstrap/js'
  serve '/bootstrap/img', from: 'public/bootstrap/img'

  # The second parameter defines where the compressed version will be served.
  # (Note: that parameter is optional, AssetPack will figure it out.)
  base_libs = [
    '/js/lib/jquery.js',
    '/js/lib/underscore.js',
    '/js/lib/backbone.js',
    '/js/lib/backbone-forms.js',
    '/bootstrap/js/bootstrap.min.js']

  js :app, '/js/app.js', base_libs.concat([
      '/js/*.js'
    ])

  js :admin, '/js/admin.js', base_libs.concat([
      '/js/admin/*.js'
    ])
        

  css :app, '/css/app.css', [
      '/css/style.css'
    ]

  css :admin, '/css/adm.css', [
      '/css/admin.css',
      '/bootstrap/css/bootstrap.min.css'
    ]

}

require_relative 'models/init'
require_relative 'routes/init'
require_relative 'helpers/init'