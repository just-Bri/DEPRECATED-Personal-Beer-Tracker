class BreweriesController < ApplicationController
  get '/breweries/:id' do #Load specific beer
    if session[:user_id]
      @brewery = Brewery.find_by_id(params[:id])
      erb :'breweries/show_brewery'
    else
      redirect to '/login'
    end
  end
end
