class UsersController < ApplicationController
  get '/signup' do #If not logged in go to user creation form
    if !session[:user_id]
      erb :'users/create_user'
    else
      redirect to '/beers'
    end
  end

  post '/signup' do #Create new user unless input is blank
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    @user.save
    session[:user_id] = @user.id #Set session for future reference
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      "<h1>Oops..An error occurred.</h1>
      <p>You left something blank!</p>"
    else
      redirect to '/beers'
    end
  end

  get '/login' do #Go to user's beers, unless they are not logged in
    if !session[:user_id]
      erb :'users/login'
    else
      redirect '/beers'
    end
  end

  post '/login' do #Login if User exists, if not redir to singup
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/beers"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do #Logout user by clearing session
    session.destroy
    erb :index
  end
end
