require './lib/train'
require './lib/cities'
require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'pg'
also_reload 'lib/**/*.rb'

DB = PG.connect({:dbname => "train_system_test"})

get ('/') do
  City.clear()
end

get('/cities') do
  @cities = City.all
  erb(:cities)
end

get('/cities/new') do
  erb(:new_city)
end

post('/cities') do
  name = params[:city_name]
  city = City.new({:name => name, :id => nil})
  city.save()
  redirect to('/cities')
end

get('/cities/:id') do
  @city = City.find(params[:id].to_i())
  erb(:city)
end

get ('/cities/:id/edit') do
  @city = City.find(params[:id].to_i())
  erb(:edit_city)
end

patch ('/cities/:id') do
  @city = City.find(params[:id].to_i())
  @city.update(params[:name])
  redirect to('/cities')
end

delete ('/cities/:id') do
  @city = City.find(params[:id].to_i())
  @city.delete()
  redirect to('/cities')
end

get ('/cities/:id/trains/:train_id') do
  @train = Train.find(params[:train_id].to_i())
  erb(:train)
end

post ('/cities/:id/trains') do
  @city = City.find(params[:id].to_i())
  train = Train.new({:name => params[:train_name], :city_id => @city.id, :id => nil})
  train.save()
  erb(:city)
end

patch ('/cities/:id/trains/:train_id') do
  @city = City.find(params[:id].to_i())
  train = Train.find(params[:train_id].to_i())
  train.update(params[:name], @city.id)
  erb(:city)
end

delete ('/cities/:id/trains/:train_id') do
  train = Train.find(params[:train_id].to_i())
  train.delete
  @city = City.find(params[:id].to_i())
  erb(:city)
end
