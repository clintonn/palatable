class ReviewsController < ApplicationController

  def new
    if !find_user
      redirect_to root_path
    elsif !find_restaurant
      @review = Review.new
      render :new
    elsif !@user.owns_restaurant_review(@restaurant).empty?
      redirect_to @restaurant
    else
      @review = Review.new
    end
  end

  def dummy_new
    if find_user
      @restaurant = Restaurant.new(name: session[:dummy_restaurant]["name"], address: session[:dummy_restaurant]["address"], foursquare_id: session[:dummy_restaurant]["foursquare_id"])
      # above fills in info for dummy review page
      @review = Review.new
      render :new
    else
      redirect_to login_path
    end
  end

  def create
    find_user
    if params[:restaurant]
      @restaurant = Restaurant.find_by(foursquare_id: params[:restaurant][:foursquare_id])
      @restaurant ||= Restaurant.new(foursquare_id: params[:restaurant][:foursquare_id])
      @restaurant.set_attributes
    elsif !params[:review][:restaurant_id].empty?
      @restaurant = Restaurant.find(params[:review][:restaurant_id])
    else
      @restaurant = Restaurant.find_by(foursquare_id: params[:review][:foursquare_id])
      @restaurant ||= Restaurant.create(name: session[:dummy_restaurant]["name"], address: session[:dummy_restaurant]["address"], foursquare_id: session[:dummy_restaurant]["foursquare_id"])
    end
    @review = Review.new(review_params)
    @review.user = @user
    @restaurant.set_attributes
    @restaurant.save
    @review.restaurant_id ||= @restaurant.id
    @review.calculate_review_avg
    if @review.save
      session[:dummy_restaurant] = nil
      redirect_to review_path(@review)
    else
      flash[:notice] = "You have already submitted a review for this restaurant."
      redirect_to new_review_path(@restaurant)
    end
  end

  def show
    find_review
    find_user
    @owned = @user.owns_review?(@review)
  end

  def edit
     @review = @review ? @review : find_review
     find_user
     if @user.owns_review?(@review)
       render :edit
     else
      redirect_to user_path(@user) #flash notice if user doesnt own review
    end
  end

  def update
    find_review
    @review.update(review_params)
    @review.calculate_review_avg
    redirect_to review_path(@review)
  end

  def homepage_poster
    find_user
    @review = Review.new(title: params[:review][:title], content: params[:review][:content], user_id: @user.id)
    @search = Search.create(search: params[:review][:search], location: params[:review][:location])
    @search.set_query_url
    # not sure if we can DRY up this conditional handling a 400 request
    query = RestClient.get(@search.api_url){ | response, &block |
      if response.code == 200
        response.return!
      else
        false
      end
    }
    if query
      @restaurants = JSON.parse(query)["response"]["venues"]
      @restaurants = @search.map_restaurants(@restaurants)
    else
      flash[:notice] = "No search results: make sure your location includes a state or zip code."
    end
    render :preview
  end

  def destroy
    find_review
    find_user
    @restaurant = @review.restaurant
    @review.destroy
    redirect_to user_path (@user)
  end
  private

  def review_params
    params.require(:review).permit(:title, :content, :food_rating, :environment_rating, :service_rating, :user_id, :restaurant_id, :search, :location)
  end

  def find_review
    @review = Review.find(params[:id])
  end

  # find_user
  # place in application controller? or private method in reviews

  def find_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end
