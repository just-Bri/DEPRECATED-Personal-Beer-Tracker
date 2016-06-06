class BreweriesController < ApplicationController
  get '/breweries/:id' do #Load specific beer
    @brewery = Brewery.find_by_id(params[:id])
    erb :'breweries/show_brewery'
  end
end
