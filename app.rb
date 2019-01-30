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
  validates :ename, presence: true, length: {minimum: 3 }
  validates :email, presence: true
  validates :message, presence: true

end

before do

  @barbers = Barber.all

end

get '/' do

	erb :index
end

get '/visit' do
  @cl = Client.new
  erb :visit
end

get '/contacts' do
  @con = Contact.new
  erb :contacts
end

post '/visit' do

  @cl = Client.new params[:client]

  if @cl.save
    erb "OK #{params[:client][:name]}; вы записаны на #{params[:client][:datestamp]}; ваш мастер #{params[:client][:barber]}; выбранный цвет #{params[:client][:color]}"
  else
    @error = @cl.errors.full_messages.first
    erb :visit
  end

end


post '/contacts' do

  @con = Contact.new params[:contact]

  if @con.save
    erb "Спасибо за обращение, в ближайшее время вам ответят"
  else
    @error = @con.errors.full_messages.first
    erb :contacts
  end

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