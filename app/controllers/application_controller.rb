class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    @search = Search.new
  end

  def analytics
  end

  private

  def authenticate_user
    # redirect_to root_path if !logged_in?
  end

  def logged_in?
    !!session[:user_id]
  end

  private

    # find_user
    # place in application controller? or private method in reviews
    def find_user
      @user = User.find(session[:user_id]) if session[:user_id]
    end

end
