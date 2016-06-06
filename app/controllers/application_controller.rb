require './config/environment'


class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "golfclubsaregreat"
  end

  def view_exists?(view)
    File.exists?(Dir.pwd + "/views/#{view}.erb")
  end

  get '/' do
    erb :index #Home page
  end

  # get '/*' do
  #   @domain = request.env["HTTP_HOST"].sub(/^(?:www)\./, '')
  #
  #   view = @domain
  #   view = 'not_sure' unless view_exists?(@domain)
  #   erb view.to_sym
  # end

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
