class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    @search = Search.new
  end

  private

  def authenticate_user
    # redirect_to root_path if !logged_in?
  end

  def logged_in?
    !!session[:user_id]
  end

end
