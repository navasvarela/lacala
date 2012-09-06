def admin_haml(template, options={})
  haml(template, options.merge(:layout => :'admin/layout'))
end

get '/admin/?' do
  css :app
  admin_haml :'admin/list'
end

get '/admin/pages' do
  @pages = Page.all

  @pages.to_json
end

put '/admin/pages/:id' do
  payload = request.body.read
  logger.info "Received JSON for #{params[:id]}: #{payload}"
  page = Page[params[:id]]
  logger.info "Attempting to update #{page.to_json}"
  page.parse_json payload
  page.save_changes

end

get '/admin/dishes' do
  Dish.all.to_json
end

put '/admin/dishes/:id' do
  payload = request.body.read
  logger.info "Received JSON for #{params[:id]}: #{payload}"
  dish = Dish[params[:id]]
  dish.parse_json payload
  dish.save_changes
end

post '/admin/dishes' do
  payload = request.body.read
  logger.info "Received JSON: #{payload}"
  dish = Dish.new
  dish.parse_json payload
  dish.save
end

