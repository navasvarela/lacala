class LaCalaMainApp < Sinatra::Base
  set :root, File.expand_path('.')
  
  register Sinatra::AssetPack

  # Assets configuration. Needs to go outside Sinatra::Application to work.
  assets {
    serve '/js',     from: 'public/js'        # Optional
    serve '/css',    from: 'public/css'       # Optional
    serve '/img', from: 'public/img'    # Optional
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
      '/bootstrap/js/bootstrap.min.js',
      '/js/lib/handlebars.js']

    js :app, '/js/app.js', base_libs.concat([
      '/js/*.js'
    ])

    js :admin, '/js/admin.js', base_libs.concat([
      '/js/admin/*.js'
    ])

    css :app, '/css/app.css', [
      '/css/styles.css'
    ]

    css :admin, '/css/adm.css', [
      '/css/admin.css',
      '/bootstrap/css/bootstrap.min.css'
    ]

  }

  configure :production do
    set :haml, { :ugly=>true }
    set :clean_trace, true

  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    @page = DB[:pages][:title => 'Home']
    haml :index
  end

  get '/quote' do
    haml :quote
  end

  get '/pages/:title' do |title|
    logger.info "Getting page with title: #{title}"
    @page = DB[:pages][:title => title]
    logger.info "Returning page #{@page}"
    haml :index
  end
end

