# Administration routes
def admin_haml(template, options={}) 
  haml(template, options.merge(:layout => :'admin/layout')) 
end

get '/admin' do
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

