require './app'

map '/' do
  run LaCalaMainApp
end

map '/admin' do
  run LaCalaAdminApp
end
