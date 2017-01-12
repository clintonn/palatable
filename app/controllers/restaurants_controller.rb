class RestaurantsController < ApplicationController

  def dummy_create
    session[:dummy_restaurant] = Restaurant.new(name: params[:name], address: params[:address].join("~"), foursquare_id: params[:foursquare_id])
    session[:reformatted_address] = session[:dummy_restaurant].address.split("~")
    session[:dummy_restaurant].populate_show
    render :'/restaurants/dummy_show'
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @restaurant.populate_show
    @restaurant.save
    find_user
    @user_review = @user.owns_restaurant_review(@restaurant)[0]
    # @user_review = find this own user's review in the @restaurant.reviews array
    # if restaurant.reviews include review in user.reviews, set flag to true
  end


  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :foursquare_id)
  end



end
