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

class Contact < ActiveRecord::Base

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

get '/contacts' do
  erb :contacts
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

post '/contacts' do
  @ename = params[:ename]
  @email = params[:email]
  @message = params[:message]


  hh = {
      :ename => "Введите ваше имя пожалуйста.",
      :email => "Введите адрес электронной почты",
      :message => "Ваше сообщение пусто - введите текст сообщения",
  }

  @error = hh.select {|key, | params[key] == ""}.values.join(", ")

  if @error != ""
    return  erb :contacts
  else
    @error = NIL
  end

  contact = Contact.new
  contact.ename = @ename
  contact.email = @email
  contact.message = @message
  contact.save


  # erb :contacts_mess
  erb "Спасибо за обращение, в ближайшее время вам ответят"
  # erb :contacts
end