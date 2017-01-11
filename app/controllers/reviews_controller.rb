class ReviewsController < ApplicationController

  def new
    if find_user && (find_restaurant || session[:dummy_restaurant])
      @review = Review.new
      render :new
    else
      redirect_to root_path
    end
  end

  def dummy_new
    if find_user
      @restaurant = Restaurant.new
      @review = Review.new
      render :new
    else
      redirect_to root_path
    end
  end

  def create
    @restaurant = Restaurant.new(name: session[:dummy_restaurant]["name"], address: session[:dummy_restaurant]["address"], foursquare_id: session[:dummy_restaurant]["foursquare_id"])
    @review = Review.new(review_params)
    @review.calculate_review_avg
    @restaurant.save
    @review.restaurant_id ||= @restaurant.id
    if @review.save
      redirect_to review_path(@review)
    else
      redirect_to new_review_path
    end
  end

  def show
    find_review
    find_user
    @owned = @user.owns_review?(@review)
  end

  def edit
     find_review
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

  def destroy
    find_review
    @restaurant = @review.restaurant
    @review.destroy
    redirect_to @restaurant
  end

  private

    def review_params
        params.require(:review).permit(:content, :food_rating, :environment_rating, :service_rating, :user_id, :restaurant_id)
    end

    def find_review
      @review = Review.find(params[:id])
    end

    # find_user
    # place in application controller? or private method in reviews
    def find_user
      @user = User.find(session[:user_id])
    end

    def find_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end


end
