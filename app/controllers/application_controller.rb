require './config/environment'
require 'sinatra'
require 'sinatra/advanced_routes'

class ApplicationController < Sinatra::Base
  register Sinatra::AdvancedRoutes

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

  get '/*' do
    binding.pry
    @routes_all = []
    self::Application.each_route.path_info {|r| @routes_all < r}
    if @routes_all.include?(request.path_info)
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
