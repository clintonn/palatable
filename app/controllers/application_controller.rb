class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    #code
  end

  private

  def authenticate_user

  end

  def logged_in?
    !!session[:user_id]
  end

end
