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

post '/admin/pages/:id' do
  
end

