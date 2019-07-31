require './lib/train'
require './lib/cities'
require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'pg'
also_reload 'lib/**/*.rb'

get ('/') do

end
