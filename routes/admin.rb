class LaCalaAdminApp < Sinatra::Base
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

   

    js :admin, '/js/admin.js', base_libs.concat([
      '/js/admin/templates.js',
      '/js/admin/*.js'
    ])

    

    css :admin, '/css/adm.css', [
      '/css/admin.css',
      '/bootstrap/css/bootstrap.min.css'
    ]

  }

  use Rack::Auth::Basic, "Restricted Area" do |username, password|
    [username, password] == ['admin', '4nn3l13s3']
  end

  configure :production do
    set :haml, { :ugly=>true }
    set :clean_trace, true

  end

  configure :development do
    register Sinatra::Reloader
  end

  def admin_haml(template, options={})
    haml(template, options.merge(:layout => :'admin/layout'))
  end

  get '/' do
    css :app
    admin_haml :'admin/list'
  end

  get '/pages' do
    @pages = Page.all

    @pages.to_json
  end

  put '/pages/:id' do
    payload = request.body.read
    logger.info "Received JSON for #{params[:id]}: #{payload}"
    page = Page[params[:id]]
    logger.info "Attempting to update #{page.to_json}"
    page.parse_json payload
    page.save_changes

  end

  get '/dishes' do
    Dish.all.to_json
  end

  put '/dishes/:id' do
    payload = request.body.read
    logger.info "Received JSON for #{params[:id]}: #{payload}"
    dish = Dish[params[:id]]
    dish.parse_json payload
    dish.save_changes
  end

  post '/dishes' do
    payload = request.body.read
    logger.info "Received JSON: #{payload}"
    dish = Dish.new
    dish.parse_json payload
    dish.save
  end
end
