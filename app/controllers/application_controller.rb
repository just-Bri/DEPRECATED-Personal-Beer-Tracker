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
    ApplicationController::all_routes
    if @@endpoints.include?(request.path_info)
      pass
    else
      erb :not_sure
    end
  end

  def self.all_routes
    @@endpoints= {}
    if Sinatra::Application.descendants.any?
      #Classic application structure
      applications = Sinatra::Application.descendants
      applications.each do |app|
        @@endpoints[app.to_s.downcase.to_sym] = app.routes
      end
    elsif Sinatra::Base.descendants.any?
      #Modular application structure
      applications = Sinatra::Base.descendants
      applications.each do |app|
        @@endpoints[app.to_s.downcase.to_sym] = app.routes
      end
    else
      abort("Cannot find any defined routes.....")
    end

    @@endpoints.each do |app_name,routes|
      puts "Application: #{app_name}\n"
      routes.each do |verb,handlers|
        puts "\n#{verb}:\n"
        handlers.each do |handler|
          puts handler[0].source.to_s
        end
      end
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
