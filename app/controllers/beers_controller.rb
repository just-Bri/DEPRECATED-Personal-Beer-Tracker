class BeersController < ApplicationController
  get '/beers' do #Display user's beers, go to login if no session
    if session[:user_id]
      @user = User.find(session[:user_id])
      @beers = @user.beers
      erb :'beers/beers'
    else
      redirect to '/login'
    end
  end

  get '/beers/new' do #New beer form
    if session[:user_id]
      erb :'beers/create_beer'
    else
      redirect to '/login'
    end
  end

  post '/beers' do #Create and save new beer and redir to show
    if params[:content] == ""
      redirect to "/beers/new"
    else
      @user = User.find_by_id(session[:user_id])
      @brewery = Brewery.find_or_create_by(:name => params[:brewery])
      @beer = Beer.create(:user => @user, :name => params[:name], :style => params[:style], :brewery => @brewery, :score => params[:score])
      redirect to "/beers"
    end
  end

  get '/beers/:id' do #Load specific beer
    if session[:user_id]
      @beer = Beer.find_by_id(params[:id])
      erb :'beers/show_beer'
    else
      redirect to '/login'
    end
  end

  get '/beers/:id/edit' do #Load edit page for specific beer
    if session[:user_id]
      @beer = Beer.find_by_id(params[:id])
      if @beer.user_id == session[:user_id]
       erb :'beers/edit_beer'
      else
        redirect to '/beers'
      end
    else
      redirect to '/login'
    end
  end

  post '/beers/:id' do #Load edit page, if beer does not exist Create/Save it
    if params[:content] == ""
      redirect to "/beers/#{params[:id]}/edit"
    else
      @beer = Beer.find_by_id(params[:id])
      @beer.score = params[:score]
      @beer.save
      redirect to "/beers/#{@beer.id}"
    end
  end

  post '/beers/:id/delete' do #Delete specific beer by id
    @beer = Beer.find_by_id(params[:id])
    @brewery = @beer.brewery
    if session[:user_id]
      @beer = Beer.find_by_id(params[:id])
      @beer.delete
      redirect to "/breweries/#{@brewery.id}"
    else
      redirect to '/login'
    end
  end
end
