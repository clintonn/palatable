class RestaurantsController < ApplicationController

  def dummy_create
    find_user # again, find_user doesn't immediately connote to me that this sets the current user or the "null user"
    session[:dummy_restaurant] = Restaurant.new(name: params[:name], address: params[:address].join("~"), foursquare_id: params[:foursquare_id])
    session[:reformatted_address] = session[:dummy_restaurant].address.split("~")
    session[:dummy_restaurant].set_attributes
    render :'/restaurants/dummy_show'
  end

  def show
    find_user
    @restaurant = Restaurant.find(params[:id])
    @restaurant.set_attributes
    # what this does isn't totally explict upon first looking at the code
    # Think about a better way to name this
    @restaurant.save
    @user_review = @user.owns_restaurant_review(@restaurant)[0] if @user
    if @user_review
      @reviews = @restaurant.first_x_reviews(9)
      # I think if you're using it for this purpose, I'd write a method
      # called most_recent_reviews that accepts a param
    else
      @reviews = @restaurant.first_x_reviews(10)
    end
  end

  def all_reviews
    # ? are these all the reviews for all the restaurants? confused. where
    # is the data?
    render :'/restaurants/all_reviews'
  end


  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :foursquare_id)
  end

end
