#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'bigdecimal'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 3 }
  validates :phone, presence: true
  validates :datestamp, presence: true
  validates :barber, presence: true
  validates :color, presence: true

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
  @cl = Client.new
  erb :visit
end

get '/contacts' do
  erb :contacts
end

post '/visit' do


  @cl = Client.new params[:client]

  if @cl.save
  # erb :visit_mess
    erb "OK #{params[:client][:name]}; вы записаны на #{params[:client][:datestamp]}; ваш мастер #{params[:client][:barber]}; выбранный цвет #{params[:client][:color]}"
  else
    @error = @cl.errors.full_messages.first
    erb :visit

  end
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

get '/barber/:id' do
  @barber = Barber.find(params[:id])
  erb :barber
end

get '/bookings' do
  @booking = Client.order 'created_at desc'
  erb :bookings
end

get '/bookings/:id' do
  @client = Client.find(params[:id])
  erb :client
end