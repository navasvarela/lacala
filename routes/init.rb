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

require_relative 'admin'
