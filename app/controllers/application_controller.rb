class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?

  def index
    # If this is meant to be the root path, I would subclass
    # ApplicationController so that you have a home or landing controller
    # and have the root path point to that controller and action
    # The application controller should really be reserved for shared
    # methods among all the controllers
    find_user
    @review = Review.new
    @search = Search.new
  end

  def analytics
    # this seems misleading especially since it's in the
    # ApplicationController
    # Update: Okay, I get it now. Again, I would advise putting this into a
    # separate controller
    # And then I would pass the data into the analytics view via instance
    # methods rather than calling a class method in the view. That's
    # typically not a great practice.
    # e.g. @top_restaurants = Restaurant.top_5_rated_restaurants
    find_user
  end



  private

  def authenticate_user
    redirect_to root_path if !logged_in?
  end

  def logged_in?
    !!session[:user_id]
  end

  private

  def find_user
    # I would probably prefer a current_user to be returned
    @user = User.find(session[:user_id]) if session[:user_id]
    @user ||= User.new
  end

end
