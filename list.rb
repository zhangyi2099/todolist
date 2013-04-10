require "sinatra"
require "data_mapper"
require "haml"
DataMapper.setup(:default,"sqlite3://#{Dir.pwd}/development.db")

class List
  include DataMapper::Resource
  property :id, Serial
  property :name, String
end

#index
get '/' do
	@lists = List.all
	haml :index
end

#edit
get '/list/:id' do
	@list = List.get(params[:id])
	haml :edit
end

#create
post '/list/create' do
	list = List.create(name:params[:name])	
	redirect '/'
end

#update
put '/list/:id' do
	list = List.get(params[:id])
	list.name = params[:name]
	list.save
	redirect '/'
end
#delete
get '/list/:id/delete' do
	@list = List.get(params[:id])
	haml :delete
end
delete '/list/:id' do
	List.get(params[:id]).destroy
  redirect '/'
end

DataMapper.auto_upgrade!