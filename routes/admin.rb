# Administration routes
def admin_haml(template, options={}) 
  haml(template, options.merge(:layout => :'admin/layout')) 
end

get '/admin' do
  css :app
  admin_haml :'admin/list'  
end


post '/admin/pages' do

end

