require 'bundler'
Bundler.require
require_relative './models/firebase.rb'
require_relative './models/user.rb'

class MyApp < Sinatra::Base
  DATABASE = FlatironBase.new("https://amber-fire-4558.firebaseio.com/")
  DATABASE.add_table("users", {"name" => "Bob", "email" => "bob@bob.com", "password" => "passwordforbob"})

  get '/' do
    erb :index
  end

  post '/signup' do
    duplicates = DATABASE.search_by_attribute("email", params[:email])
    if duplicates == nil
      DATABASE.add("users", {"name" => params[:name], "email" => params[:email], "password" => params[:password]})
      redirect('/')
    else
      "Someone has already signed up with that email address. <a href='/'>Try again</a>"
    end
  end

  get '/users' do
    @users = DATABASE.get_data
    erb :users
  end
end