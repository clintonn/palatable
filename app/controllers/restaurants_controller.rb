class RestaurantsController < ApplicationController

  def dummy_create
    session[:dummy_restaurant] = Restaurant.new(name: params[:name], address: params[:address].join("~"), foursquare_id: params[:foursquare_id])
    session[:reformatted_address] = @restaurant.address.split("~")
    render :'/restaurants/dummy_show'
  end

  def show
    #code
  end



end
