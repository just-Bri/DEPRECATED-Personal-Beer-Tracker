require './config/environment'
require 'sinatra'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "beerssecret"
  end

  get '/' do
    erb :index #Home page
  end

  get '/not_yours' do
    erb :not_yours
  end

  get '/*' do #Catch All - tried using a couple different gems
              #that generate a list of all routes but couldn't get them working.
              #Still trying to find a more elegnat/RESTful way for handling this.
    @request_url = request.path_info
    @beer_routes = ["/beers", "/beers/new", "/beers/#{request.path_info.split('/').last}", "/beers/#{request.path_info.split('/')[2]}/edit"]
    @user_routes = ["/signup", "/login", "/logout"]
    @brewery_routes = ["/breweries/#{request.path_info.split('/').last}"]
    @all_routes = @beer_routes + @user_routes + @brewery_routes
    if @all_routes.include?(@request_url)
      pass
    else
      erb :not_sure
    end
  end

  helpers do
    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/login?error=You have to be logged in to do that"
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
