class RestaurantsController < ApplicationController

  def dummy_create
    find_user
    session[:dummy_restaurant] = Restaurant.new(name: params[:name], address: params[:address].join("~"), foursquare_id: params[:foursquare_id])
    session[:reformatted_address] = session[:dummy_restaurant].address.split("~")
    session[:dummy_restaurant].set_attributes
    render :'/restaurants/dummy_show'
  end

  def show
    find_user
    @restaurant = Restaurant.find(params[:id])
    @restaurant.set_attributes
    @restaurant.save
    @user_review = @user.owns_restaurant_review(@restaurant)[0] if @user
    if @user_review
      @reviews = @restaurant.first_x_reviews(9)
    else
      @reviews = @restaurant.first_x_reviews(10)
    end
  end

  def all_reviews
    render :'/restaurants/all_reviews'
  end


  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :foursquare_id)
  end

end
