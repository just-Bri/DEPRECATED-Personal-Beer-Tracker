class BeersController < ApplicationController
  get '/beers' do #Display user's beers, go to login if no session
    @id = session[:user_id]
    redirect_if_not_logged_in
    @user = User.find(session[:user_id])
    @beers = @user.beers
    erb :'beers/beers'
  end

  get '/beers/new' do #New beer form
    redirect_if_not_logged_in
    erb :'beers/create_beer'
  end

  post '/beers' do #Create and save new beer and redir to show
    redirect_if_not_logged_in
    @user = User.find_by_id(session[:user_id])
    @brewery = Brewery.find_or_create_by(:name => params[:brewery])
    @beer = Beer.find_or_create_by(:user => @user, :name => params[:name], :style => params[:style], :brewery => @brewery, :score => params[:score])
    redirect to "/beers"
  end

  get '/beers/:id' do #Load specific beer
    redirect_if_not_logged_in
    if session[:user_id]
      if !Beer.exists?(params[:id])
        erb :not_sure
      else
        @beer = Beer.find_by_id(params[:id])
        if @beer.user_id == session[:user_id]
          erb :'beers/show_beer'
        else
          redirect to './not_yours'
        end
      end
    end
  end

  get '/beers/:id/edit' do #Load edit page for specific beer
    redirect_if_not_logged_in
    if session[:user_id]
      @beer = Beer.find_by_id(params[:id])
      if @beer.user_id == session[:user_id]
       erb :'beers/edit_beer'
      else
        redirect to './not_yours'
      end
    else
      redirect to '/login'
    end
  end

  post '/beers/:id' do #Load edit page, if beer does not exist Create/Save it
    redirect_if_not_logged_in
    @beer = Beer.find_by_id(params[:id])
    if params[:new_score].empty?
      redirect to "/beers/#{@beer.id}/edit"
    else
      @beer.score = params[:new_score]
      @beer.save
      redirect "/beers/#{@beer.id}"
    end
  end

  post '/beers/:id/delete' do #Delete specific beer by id
    redirect_if_not_logged_in
    if session[:user_id]
      @beer = Beer.find_by_id(params[:id])
      if @beer.user_id == session[:user_id]
        @beer.delete
        redirect to '/beers'
      else
        redirect to './not_yours'
      end
    else
      redirect to '/login'
    end
  end
end
