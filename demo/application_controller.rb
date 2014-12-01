require 'bundler'
Bundler.require
require_relative './models/firebase.rb'
require_relative './models/user.rb'

class MyApp < Sinatra::Base
  DATABASE = FlatironBase.new("https://amber-fire-4558.firebaseio.com/")
  DATABASE.add_table("users", {"name" => "Bob", "email" => "bob@bob.com", "password" => "passwordforbob"})

  get '/' do
    @users = DATABASE.get_data
    erb :index
  end

  post '/signup' do
    DATABASE.add("users", {"name" => params[:name], "email" => params[:email], "password" => params[:password]})
      redirect('/')
  end
end