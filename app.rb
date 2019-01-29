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

before do

  @barbers = Barber.all

end

get '/' do

	erb :index
end

get '/visit' do
  # @db = get_db
  erb :visit
end

post '/visit' do

  @user_name = params[:username]
  @phone = params[:phone]
  @date_time = params[:date_time]

  @master = params[:master]
  @color = params[:colorpicker]

  cl = Client.new
  cl.name = @user_name
  cl.phone = @phone
  cl.datestamp = @date_time
  cl.barber = @master
  cl.color = @color
  cl.save



  # erb :visit_mess
  erb "OK #{@user_name}; вы записаны на #{@date_time}; ваш мастер #{@master}; выбранный цвет #{@color}"
end


