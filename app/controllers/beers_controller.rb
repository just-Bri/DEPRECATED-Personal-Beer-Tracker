class BeersController < ApplicationController
  get '/beers' do #Display user's beers, go to login if no session
    if session[:user_id]
      @beers = Beer.all
      erb :'beers/beers'
    else
      redirect to '/login'
    end
  end

  get '/beers/new' do #New tweet form
    if session[:user_id]
      erb :'beers/create_beer'
    else
      redirect to '/login'
    end
  end

  post '/beers' do #Create and save new tweet and redir to show
    if params[:content] == ""
      redirect to "/beers/new"
    else
      user = User.find_by_id(session[:user_id])
      @brewery = Brewery.find_or_create_by(:name => params[:brewery])
      @beer = Beer.create(:name => params[:name], :style => params[:style], :brewery => @brewery, :score => params[:score])
      redirect to "/beers/#{@beer.id}"
    end
  end
end
