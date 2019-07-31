require './lib/train'
require './lib/city'
require 'sinatra'
require 'sinatra/reloader'
require './lib/stop'
require 'pry'
require 'pg'
also_reload 'lib/**/*.rb'

DB = PG.connect({:dbname => "train_system_test"})

city = City.new({:name => "Portland", :id => nil})
city.save()
city2 = City.new({:name => "Seattle", :id => nil})
city2.save()
train = Train.new({:name => "Red line", :id => nil})
train.save()
train2 = Train.new({:name => "Blue line", :id => nil})
train2.save()
stop = Stop.new({:city => city, :train => train, :time => '13:00:00'})
stop.save()
stop2 = Stop.new({:city => city, :train => train2, :time => '13:00:00'})
stop2.save()
stop3 = Stop.new({:city => city2, :train => train2, :time => '15:00:00'})
stop3.save()

get ('/') do
  Stop.clear
  City.clear
  Train.clear
  redirect to('/stops')
end

get('/stops') do
  @stops = Stop.all
  erb(:stops)
end

get('/stops/new') do
  erb(:new_stop)
end

post('/stops') do
  city = City.find(params[:city_id].to_i)
  train = Train.find(params[:train_id].to_i)
  time = params[:time]
  Stop.new({:city => city, :train => train, :time => time})
  redirect to('/stops')
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
  redirect to('/city')
end

delete ('/cities/:id') do
  @city = City.find(params[:id].to_i())
  @city.delete()
  redirect to('/cities')
end

get('/trains') do
  @trains = Train.all
  erb(:trains)
end

get('/trains/new') do
  erb(:new_train)
end

post('/trains') do
  name = params[:train_name]
  train = train.new({:name => name, :id => nil})
  train.save()
  redirect to('/trains')
end

get ('/trains/:id') do
  @train = Train.find(params[:id].to_i())
  erb(:train)
end

get ('/trains/:id/edit') do
  @train = Train.find(params[:id].to_i())
  erb(:edit_train)
end

patch ('/trains/:id') do
  @train = Train.find(params[:id].to_i())
  train.update(params[:name])
  erb(:train)
end

delete ('/trains/:id') do
  train = Train.find(params[:id].to_i())
  train.delete
  erb(:train)
end
