#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'bigdecimal'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base

end

class Barber < ActiveRecord::Base

end

get '/' do
	erb :index
end