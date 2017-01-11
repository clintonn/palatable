class ReviewsController < ApplicationController

  def new
    find_user
    find_restaurant
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to review_path(@review)
    else
      redirect_to new_review_path
    end
  end

  def show
    find_review
  end

  def edit
     find_review
  end

  def update
    find_review
    @review.update(review_params)
    redirect_to review_path(@review)
  end

  def destroy
    find_review
    @review.destroy
    redirect_to new_review_path
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
